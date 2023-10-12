extends Projectile
class_name KinematicProjectile

func _ready():
	gravity_scale = 0

func __on_initial_velocity_set(direction: Vector2, speed: float):
	apply_central_impulse(direction*speed)
