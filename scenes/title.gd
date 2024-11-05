extends RichTextLabel


var title = "[center]FROGGY  HOP[/center]"
# var msg = "[center][wave amp=100 freq=3]FROGGY  HOP[/wave][/center]"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# self.text = "[center]FROGGY HOP[/center]"
	self.text = ""
	self.append_text(title)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# self.text = "[center][tornado radius=10 freq=2.2]FROGGY  HOP[/tornado][/center]"
	# self.text = "[center][wave amp=10 freq=4]FROGGY  HOP[/wave][/center]"
	# self.text = "[center][wave amp=80 freq=3]FROGGY  HOP[/wave][/center]"
	pass
