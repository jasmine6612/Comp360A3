extends Node3D

@export var spark_particles: GPUParticles3D
@export var follow_target: NodePath 

var _target: Node3D

func _ready() -> void:
	if follow_target != NodePath():
		_target = get_node_or_null(follow_target)
	
	_configure_particles(spark_particles)

func trigger_at(position: Vector3) -> void:
	if spark_particles:
		spark_particles.global_position = position
		spark_particles.restart()
		spark_particles.emitting = true

func _configure_particles(p: GPUParticles3D) -> void:
	if p == null:
		return
	p.local_coords = false
	p.one_shot = true
	p.emitting = false  # Start off
