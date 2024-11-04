class_name MoveComponent
extends Node2D

@export var offset = 32
@export var origin = 0.0

@onready var area: Node2D = $".."
@onready var root: Node2D = $"../.."


@export var speed:int = 96
@export_enum("Left:-1", "Right:1") var move_dir: int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta) -> void:
	# print(move_dir)
	var vel = Vector2(move_dir, 0) * speed
	# print(vel)
	root.translate(vel * delta)
	
	if move_dir > 0:  # moving right
		if root.global_position.x > Global.w + offset:
			# print("MOVE TO: ", origin)
			root.global_position.x = origin
	else:  # moving left
		if root.global_position.x < origin - offset:
			# print("MOVE TO: ", Global.w + offset)
			root.global_position.x = Global.w + offset
