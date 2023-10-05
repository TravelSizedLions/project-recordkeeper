extends Projectile

func set_initial_velocity(direction: Vector2, speed: float):
	add_constant_central_force(direction*speed)
