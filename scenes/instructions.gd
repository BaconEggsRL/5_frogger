extends Label

# Speed of the floating effect
@export var float_speed: float = 1.0
# Distance the label will float up and down
@export var float_amplitude: float = 10.0

# Starting y-position of the label
var start_y: float

func _ready() -> void:
	# Store the initial y position
	start_y = position.y

func _process(delta: float) -> void:
	# Update the y position with a sine wave to create the floating effect
	# position.y = start_y + sin(Time.get_ticks_msec() / 1000.0 * float_speed) * float_amplitude
	pass
