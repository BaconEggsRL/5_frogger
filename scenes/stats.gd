extends Node2D

@export var best_score_label:Label
@export var best_time_label:Label



func _ready() -> void:
	Global.current_scene = self
	update_labels()



func update_labels() -> void:
	var best_score = Global.save_data.best_score
	var best_time = Global.save_data.best_time
	
	
	if best_score:
		best_score_label.text = str(best_score)
		print("best_score")
		print(best_score, best_time)
	else:
		best_score_label.text = "N/A"
		print("no best_score")
		print(best_score, best_time)
		
	if best_time:
		best_time_label.text = str(snapped(best_time, 0.01)) + " seconds"
		print("best_time")
		print(best_score, best_time)
	else:
		best_time_label.text = "N/A"
		print("no best_time")
		print(best_score, best_time)
	
	
func _on_back_btn_pressed() -> void:
	Global.to_main()


func _on_clear_btn_pressed() -> void:
	Global.save_data.clear()
	update_labels()
