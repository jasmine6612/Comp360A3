extends Node3D

@onready var spark_particles: GPUParticles3D

func trigger_at(pos: Vector3):
	if spark_particles:
		spark_particles.global_position = pos
		spark_particles.emitting = true
		spark_particles.restart()
		
		
