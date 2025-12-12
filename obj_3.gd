extends MeshInstance3D

@export var move_distance: float = 1.5
@export var speed: float = 2.5
var direction: int = 1
var start_pos: Vector3

func _ready():
	start_pos = global_transform.origin

func _process(delta):
	var new_pos = global_transform.origin
	new_pos.x += speed * direction * delta
	if abs(new_pos.x - start_pos.x) > move_distance:
		direction *= -1
	global_transform.origin = new_pos
