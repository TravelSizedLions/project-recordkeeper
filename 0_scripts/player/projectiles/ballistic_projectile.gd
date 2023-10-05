extends Projectile

@onready var body: RigidBody2D = get_node('./')

func set_initial_velocity(direction: Vector2, speed: float):
	body.apply_central_impulse(direction*speed)
	body.rotation = direction.angle()

func _process(delta):
	body.rotation = body.linear_velocity.angle()
