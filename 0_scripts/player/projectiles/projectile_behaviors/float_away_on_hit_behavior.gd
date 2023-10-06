extends ProjectileOnHitBehavior
class_name FloatAwayOnContact

## The upward force applied to any rigidbody the projectile makes contact with
@export var upward_force: float = 300

@onready var player: Player = get_tree().get_first_node_in_group('player')

func on_hit(body):
	if body != player and body is RigidBody2D:
		var rb: RigidBody2D = body
		rb.freeze = false
		rb.lock_rotation = false
		rb.gravity_scale = 0
		rb.apply_central_impulse(Vector2.UP*upward_force)

