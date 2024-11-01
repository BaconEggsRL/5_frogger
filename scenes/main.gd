extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.current_scene = self
	# Global.play_sound("music")


func _on_play_btn_pressed() -> void:
	Global.to_game()
