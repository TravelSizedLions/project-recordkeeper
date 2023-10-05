extends Projectile

func set_initial_velocity(direction: Vector2, speed: float):
	apply_central_impulse(direction*speed)
	rotation = direction.angle()

func _process(delta):
	rotation = linear_velocity.angle()
