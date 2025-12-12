extends CharacterBody3D

@export var move_speed: float = 4.5
@export var turn_speed: float = 10.0
@export var mouse_sensitivity: float = 0.003

@export var smash_cooldown: float = 0.4
@export var smash_debug: bool = true

@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var visual: Node3D = $Visual
@onready var anim: AnimationPlayer = $Visual/arm/AnimationPlayer
@onready var smash_area: Area3D = $SmashArea

var pitch: float = -0.35
var _move_dir: Vector3 = Vector3.ZERO
var _can_smash: bool = true


func _ready() -> void:
	if anim and anim.has_animation("idle"):
		anim.play("idle")


func _physics_process(delta: float) -> void:
	_handle_move(delta)

	# Smash / grab action
	if Input.is_action_just_pressed("ui_accept"):
		_do_smash()


func _handle_move(delta: float) -> void:
	# Input vector (supports arrows + WASD if mapped to ui_* actions)
	var input_vec: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# Camera forward/right (flattened)
	var cam_forward: Vector3 = spring_arm.global_transform.basis.z
	cam_forward.y = 0.0
	cam_forward = cam_forward.normalized()

	var cam_right: Vector3 = spring_arm.global_transform.basis.x
	cam_right.y = 0.0
	cam_right = cam_right.normalized()

	# Move direction
	_move_dir = (cam_right * input_vec.x + cam_forward * input_vec.y)
	if _move_dir.length() > 1.0:
		_move_dir = _move_dir.normalized()

	# Apply velocity
	velocity.x = _move_dir.x * move_speed
	velocity.z = _move_dir.z * move_speed

	# Rotate the visual to face movement direction (your fixed facing)
	if _move_dir.length() > 0.01:
		var target_yaw: float = atan2(-_move_dir.x, -_move_dir.z)
		visual.rotation.y = lerp_angle(visual.rotation.y, target_yaw, delta * turn_speed)

	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	# Hold right mouse button (camera_drag) and move mouse to rotate
	if event is InputEventMouseMotion and Input.is_action_pressed("camera_drag"):
		rotation.y -= event.relative.x * mouse_sensitivity
		pitch = clamp(pitch - event.relative.y * mouse_sensitivity, -1.1, -0.2)
		spring_arm.rotation.x = pitch


func _do_smash() -> void:
	if not _can_smash:
		return
	_can_smash = false

	# 1) Play grab/pickup once
	var played_name := ""
	if anim:
		if anim.has_animation("grab"):
			played_name = "grab"
		elif anim.has_animation("pickup"):
			played_name = "pickup"
		elif anim.has_animation("letgo"):
			played_name = "letgo"

	if anim and played_name != "":
		anim.play(played_name)

	# 2) Break things that overlap (bodies)
	for body in smash_area.get_overlapping_bodies():
		if body != self and body.is_in_group("breakable"):
			if body.has_method("break_object"):
				body.break_object(global_transform.origin)
			else:
				body.queue_free()

	# 3) Optional: break via overlapping areas too (if needed)
	for a in smash_area.get_overlapping_areas():
		var p := a.get_parent()
		if p and p != self and p.is_in_group("breakable"):
			if p.has_method("break_object"):
				p.break_object(global_transform.origin)
			else:
				p.queue_free()

	# 4) Return to idle after animation time (or small fallback)
	var wait_time := smash_cooldown
	if anim and played_name != "" and anim.has_animation(played_name):
		wait_time = max(smash_cooldown, anim.get_animation(played_name).length)

	await get_tree().create_timer(wait_time).timeout

	if anim and anim.has_animation("idle"):
		anim.play("idle")

	_can_smash = true
