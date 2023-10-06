extends Projectile
class_name BallisticProjectile

var freeze_position: Vector2
var freeze_rotation: float

func set_initial_velocity(direction: Vector2, speed: float):
	apply_central_impulse(direction*speed)
	rotation = direction.angle()

func _integrate_forces(_state):
	if not freeze:
		rotation = linear_velocity.angle()

func on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if not freeze:
		call_deferred('freeze_projectile', body)

func on_body_entered(body):
	if not freeze:
		call_deferred('freeze_projectile', body)

func freeze_projectile(body):
	set_linear_velocity(Vector2.ZERO)
	freeze = true 
	lock_rotation = true
	
	var collider: CollisionShape2D = $collision_shape_2d
	collider.queue_free()
	
	var parent = get_parent()
	if parent:
		parent.remove_child(self)
		body.add_child(self)
		body.move_child(self, 0)
