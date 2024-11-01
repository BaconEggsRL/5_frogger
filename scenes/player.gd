extends Node2D

var full_tiles:Array[Vector2i] = []

const MAX_LILYPADS = 5

var score:int = 0
var best_lane:int = 0
var lane_score:int = 10
var lilypad_score:int = 500
@export var score_label:Label

var spawn_pos = Vector2(480, 800)

const MAX_LIVES = 3
var lives_left = MAX_LIVES
@export var lives_container:HBoxContainer
const LIFE = preload("res://scenes/life.tscn")

@export var frog_sprite_container:Node2D
const FROG_SPRITE = preload("res://scenes/frog_sprite.tscn")


@export var gameover_container:Control
@export var win_container:Control

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var reticle: Sprite2D = $reticle
@onready var ray_cast_2d: RayCast2D = $RayCast2D

@export var SPEED = 8
var tile_size = 64
@export var tilemap:TileMapLayer

var is_moving:bool = false
var is_dying:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var current_tile:Vector2i = tilemap.local_to_map(global_position)
	best_lane = current_tile.y
	print(best_lane)
	
	self.position = spawn_pos
	
	for i in MAX_LIVES:
		lives_container.add_child(LIFE.instantiate())
	
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
	
	
	
	# check if walkable
	var walkable = tiledata.get_custom_data("walkable")
	if not walkable:
		return
	
	
	# check raycast
	ray_cast_2d.target_position = dir * tile_size
	ray_cast_2d.force_raycast_update()
	if ray_cast_2d.is_colliding():
		return
	
	# check if full
	if full_tiles.has(target_tile):
		return
	
	
	# Move player
	is_moving = true
	Global.play_sound("jump")
	sprite_2d.play("jump")
	global_position = tilemap.map_to_local(target_tile)
	
	# Animate sprite
	sprite_2d.global_position = tilemap.map_to_local(current_tile) # - Vector2(32,32)
	
	# increment score
	if target_tile.y < best_lane:
		best_lane = target_tile.y
		score += lane_score
		score_label.text = str(score)
	
	# check if reached end; reset position
	var lilypad = tiledata.get_custom_data("lilypad")
	if lilypad:
		score += lilypad_score
		var f = FROG_SPRITE.instantiate()
		f.position = self.position
		frog_sprite_container.add_child(f)
		
		# add tile to list of full tiles
		full_tiles.append(target_tile)
		
		# check if won
		if full_tiles.size() == MAX_LILYPADS:
			win_container.show()
			call_deferred("queue_free")
		else:
			# reset position and lane
			reset()



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("kill_area"):
		print("DEAD")
		Global.play_sound("dead")
		
		# decrease life count
		lives_left -= 1
		
		# remove life from container
		var lives = lives_container.get_children()
		if lives:
			lives[-1].call_deferred("queue_free")
		
		# check if game over
		if lives_left <= 0:
			gameover_container.show()
			Global.is_game_over = true
			call_deferred("queue_free")
			return
			
		# reset position and lane
		reset()


# reset position and lane
func reset() -> void:
	self.position = spawn_pos
	var current_tile:Vector2i = tilemap.local_to_map(global_position)
	best_lane = current_tile.y
