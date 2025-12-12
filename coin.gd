extends Area3D

@export var value: int = 1

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(_body: Node) -> void:
	# When something touches the coin, it disappears
	queue_free()
