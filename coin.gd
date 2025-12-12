extends Area3D

@export var spin_speed: float = 2.5
var _armed := false

func _ready() -> void:
	# Prevent instant pickup on spawn overlap
	await get_tree().create_timer(0.15).timeout
	_armed = true
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	rotation.y += spin_speed * delta

func _on_body_entered(body: Node3D) -> void:
	if not _armed:
		return
	# If you don't have groups, this is enough:
	if body.name == "RobotPlayer":
		queue_free()
