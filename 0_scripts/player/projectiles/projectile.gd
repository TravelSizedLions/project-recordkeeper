extends RigidBody2D
class_name Projectile

@export var settings: ProjectileSettings

@onready var __timer: float = settings.max_lifetime_seconds

func _physics_process(delta):
	__timer -= delta
	if __timer < 0:
		queue_free()

func set_initial_velocity(direction: Vector2, speed: float):
	pass
