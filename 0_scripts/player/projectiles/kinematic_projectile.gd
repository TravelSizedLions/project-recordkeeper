extends Projectile

@onready var body: RigidBody2D = get_node('./')

func set_initial_velocity(direction: Vector2, speed: float):
	body.add_constant_central_force(direction*speed)
