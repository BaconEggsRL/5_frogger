extends Node2D


var time_start = 0
var time_now = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.current_scene = self
	Global.play_sound("music")
	time_now = 0


# update time
func _process(delta) -> void:
	if not Global.is_game_won:
		if not Global.is_game_over:
			time_now += delta
	# update high score if game won
	else:
		if Global.save_data.best_time:
			if time_now < Global.save_data.best_time:
				Global.save_data.best_time = time_now
				Global.save_data.save()
				set_process(false)
		else:
			Global.save_data.best_time = time_now
			Global.save_data.save()
			set_process(false)
			
	# print(time_now)
			

# check inputs for UI / pause / restart
func _input(_event) -> void:
	if Input.is_action_just_pressed("restart"):
		Global.to_game()


func _on_quit_btn_pressed() -> void:
	Global.to_main()
