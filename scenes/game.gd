extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.current_scene = self
	# Play music
	Global.play_sound("music")
	
	#var lane_groups = get_tree().get_nodes_in_group("lane_group")
	#for lg in lane_groups:
		#lg.global_position.x = 500
	

# check inputs for UI / pause / restart
func _input(_event) -> void:
	if Input.is_action_just_pressed("restart"):
		Global.to_game()


func _on_quit_btn_pressed() -> void:
	Global.to_main()
