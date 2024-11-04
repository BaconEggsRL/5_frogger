class_name MoveComponent
extends Node2D

var offset = 32

@onready var parent: Node2D = $".."


@export var speed:int = 96
@export_enum("Left:-1", "Right:1") var move_dir: int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta) -> void:
	# print(move_dir)
	var vel = Vector2(move_dir, 0) * speed
	# print(vel)
	parent.translate(vel * delta)
	
	if move_dir > 0:  # moving right
		if parent.global_position.x > Global.w + offset:
			print("MOVE TO: ", 0.0)
			parent.global_position.x = 0.0
	else:  # moving left
		if parent.global_position.x < 0.0 - offset:
			print("MOVE TO: ", Global.w + offset)
			parent.global_position.x = Global.w + offset
