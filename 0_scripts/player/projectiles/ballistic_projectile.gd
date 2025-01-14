extends Projectile
class_name BallisticProjectile

var freeze_position: Vector2
var freeze_rotation: float

func _ready():
	gravity_scale = 1

func __on_initial_velocity_set(direction: Vector2, speed: float):
	apply_central_impulse(direction*speed)
	rotation = direction.angle()

func _physics_process(_delta):
	if not freeze:
		global_rotation = linear_velocity.angle()
