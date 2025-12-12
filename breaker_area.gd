extends Area3D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if body == null:
		return

	if !body.is_inside_tree():
		return

	if !body.is_in_group("breakable"):
		return

	if !body.has_method("break_object"):
		return

	var origin: Vector3 = body.global_transform.origin
	body.break_object(origin)
