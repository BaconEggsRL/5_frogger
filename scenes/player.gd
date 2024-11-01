extends Node2D


@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var reticle: Sprite2D = $reticle
@onready var ray_cast_2d: RayCast2D = $RayCast2D

@export var SPEED = 8
var tile_size = 64
@export var tilemap:TileMapLayer

var is_moving:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dir = Vector2.from_angle(sprite_2d.rotation - PI/2)
	ray_cast_2d.target_position = dir * tile_size
	ray_cast_2d.force_raycast_update()
	if ray_cast_2d.is_colliding():
		return


func _physics_process(_delta) -> void:
	if is_moving == false:
		return
		
	if global_position == sprite_2d.global_position:
		is_moving = false
		sprite_2d.play("idle")
		return
	
	sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, SPEED)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_moving:
		return
		
	if Input.is_action_pressed("up"):
		move(Vector2i.UP)
	elif Input.is_action_pressed("down"):
		move(Vector2i.DOWN)
	elif Input.is_action_pressed("left"):
		move(Vector2i.LEFT)
	elif Input.is_action_pressed("right"):
		move(Vector2i.RIGHT)


func move(dir:Vector2i) -> void:
	# change rotation
	sprite_2d.rotation = Vector2(dir).angle() + PI/2
	
	print(dir)
	# Get current tile Vector2i
	var current_tile:Vector2i = tilemap.local_to_map(global_position)
	
	# Get target tile Vector2i
	var target_tile:Vector2i = current_tile + dir
	print(current_tile, target_tile)
	
	# Get custome data layer from target tile (is walkable?)
	var tiledata:TileData = tilemap.get_cell_tile_data(target_tile)
	
	var walkable = tiledata.get_custom_data("walkable")
	
	if not walkable:
		return
		
	ray_cast_2d.target_position = dir * tile_size
	ray_cast_2d.force_raycast_update()
	if ray_cast_2d.is_colliding():
		return
		
		
	# Move player
	is_moving = true
	Global.play_sound("jump")
	sprite_2d.play("jump")
	global_position = tilemap.map_to_local(target_tile)
	# Animate sprite
	sprite_2d.global_position = tilemap.map_to_local(current_tile) # - Vector2(32,32)
	
