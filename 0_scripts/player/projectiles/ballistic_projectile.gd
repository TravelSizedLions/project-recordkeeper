extends Projectile
class_name BallisticProjectile

var freeze_position: Vector2
var freeze_rotation: float

func _ready():
	gravity_scale = 1

func set_initial_velocity(direction: Vector2, speed: float):
	apply_central_impulse(direction*speed)
	rotation = direction.angle()

func _integrate_forces(_state):
	if not freeze:
		rotation = linear_velocity.angle()
