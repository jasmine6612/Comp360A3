extends StaticBody3D

@export var coin_scene: PackedScene
@export var coin_count: int = 3
@export var coin_spread: float = 1.0

@export var ParticleController: Node3D

# We receive the world position of the box from breaker_area.gd
func break_object(origin: Vector3) -> void:
	if coin_scene == null:
		return

	var current_scene := get_tree().current_scene
	if current_scene == null:
		push_warning("No current_scene when trying to spawn coins. Ignoring.")
		return

	for i in coin_count:
		var coin := coin_scene.instantiate()
		current_scene.add_child(coin)  # put coin in the tree *first*

		var offset := Vector3(
			randf_range(-coin_spread, coin_spread),
			1.2,
			randf_range(-coin_spread, coin_spread)
		)

		# Now it's safe to use global/world position, because the coin is inside the tree
		coin.global_position = origin + offset
		# (or: coin.position = origin + offset, since parent is the root)

	queue_free()  # remove the box
	
