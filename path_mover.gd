extends PathFollow3D

@export var speed: float = 4.0
@onready var mover: Node3D = get_node("PathMover") if has_node("PathMover") else null

func _ready() -> void:
	set_process(true)
	progress = 0.0

func _process(delta: float) -> void:
	# Move along the path
	progress += speed * delta
	# Also rotate the visual child so motion is obvious even if the path is short
	if mover:
		mover.rotate_y(delta)
