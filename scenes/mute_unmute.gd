extends Button

@onready var muted:bool = false

@onready var mute_sprite: Sprite2D = $sprite_container/Mute
@onready var unmute_sprite: Sprite2D = $sprite_container/Unmute

@onready var music_bus = AudioServer.get_bus_index("music")


func _ready() -> void:
	muted = AudioServer.is_bus_mute(music_bus)
	unmute_sprite.visible = muted
	
func _on_pressed() -> void:
	muted = not muted
	unmute_sprite.visible = not unmute_sprite.visible
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))
