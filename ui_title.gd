extends Label

@export var float_amplitude: float = 6.0
@export var float_speed: float = 2.0
@export var fade_speed: float = 1.0

var _base_offset_top: float
var _time: float = 0.0
var _alpha: float = 0.0

func _ready() -> void:
	_base_offset_top = offset_top
	modulate.a = 0.0

func _process(delta: float) -> void:
	_time += delta
	# Float the label gently up and down
	offset_top = _base_offset_top + sin(_time * float_speed) * float_amplitude
	# Fade in at the start
	if _alpha < 1.0:
		_alpha = min(1.0, _alpha + fade_speed * delta)
		var c := modulate
		c.a = _alpha
		modulate = c
