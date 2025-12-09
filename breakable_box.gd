extends StaticBody3D

@export var coin_scene: PackedScene
@export var coin_count: int = 3
@export var coin_spread: float = 0.4

func break_object() -> void:
	# Called when the robot hits this box
	if coin_scene:
		var parent := get_tree().current_scene
		for i in coin_count:
			var coin := coin_scene.instantiate()
			var offset := Vector3(
				randf_range(-coin_spread, coin_spread),
				0.5,  # a bit above the floor
				randf_range(-coin_spread, coin_spread)
			)
			coin.global_transform.origin = global_transform.origin + offset
			parent.add_child(coin)

	queue_free()   # remove the box
