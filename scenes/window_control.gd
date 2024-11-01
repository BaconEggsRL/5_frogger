@tool
class_name WindowControl
extends Control

@export var debug:bool = true

# Resolution
var viewport_size:Vector2
var w
var h


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		# Editor resizing
		self.set_anchors_preset(Control.PRESET_FULL_RECT)
		ProjectSettings.settings_changed.connect(_on_project_settings_changed)
		call_deferred("_on_project_settings_changed")
		return
		
	else:
		# In-Game resizing
		#self.set_anchors_preset(Control.PRESET_FULL_RECT)
		#get_tree().get_root().size_changed.connect(_on_viewport_size_changed)
		#call_deferred("_on_viewport_size_changed")
		return
		
		
func _on_project_settings_changed() -> void:
	var temp = Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"), 
		ProjectSettings.get_setting("display/window/size/viewport_height")
	)
	resize(temp)


func _on_viewport_size_changed() -> void:
	var temp = DisplayServer.window_get_size()
	resize(temp)
	
	
func resize(s:Vector2) -> void:
	# check if size changed, if so update:
	if viewport_size:
		if viewport_size != s:
			set_viewport_size(s)
	else:
		set_viewport_size(s)
	
	# print result
	if debug:
		var msg = "w = %s, h = %s" % [w, h]
		print(msg)


func set_viewport_size(s:Vector2) -> void:
	viewport_size = s
	w = viewport_size.x
	h = viewport_size.y
	set_deferred("size", viewport_size)
