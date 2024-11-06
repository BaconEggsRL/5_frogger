extends Node2D

@export var timer_tip:Label
@export var best_tip:Label
@onready var winner: WindowControl = $UI/winner
@onready var gameover: WindowControl = $UI/gameover


var time_start = 0
var time_now = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.current_scene = self
	Global.play_sound("music")
	time_now = 0
	
	winner.hide()
	gameover.hide()


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
				timer_tip.text = "Time: %s seconds" % snapped(time_now, 0.01)
				best_tip.text = "(NEW BEST!)"
				set_process(false)
			else:
				timer_tip.text = "Time: %s seconds" % snapped(time_now, 0.01)
				best_tip.text = "(Best: %s seconds)" % snapped(Global.save_data.best_time, 0.01)
		else:
			Global.save_data.best_time = time_now
			Global.save_data.save()
			timer_tip.text = "Time: %s seconds" % snapped(time_now, 0.01)
			best_tip.text = "(NEW BEST!)"
			set_process(false)
			
	# print(time_now)
			

# check inputs for UI / pause / restart
func _input(_event) -> void:
	if Input.is_action_just_pressed("restart"):
		Global.to_game()


func _on_quit_btn_pressed() -> void:
	Global.to_main()
