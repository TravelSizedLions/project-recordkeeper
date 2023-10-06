extends Projectile
class_name KinematicProjectile

func set_initial_velocity(direction: Vector2, speed: float):
	apply_central_impulse(direction*speed)

func on_body_entered(body):
	queue_free()

func on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	queue_free()
