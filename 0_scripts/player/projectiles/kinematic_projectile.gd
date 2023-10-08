extends Projectile
class_name KinematicProjectile

func _ready():
	gravity_scale = 0

func set_initial_velocity(direction: Vector2, speed: float):
	apply_central_impulse(direction*speed)
