extends Projectile
class_name KinematicProjectile

var _constant_velocity: Vector2

func _ready():
	gravity_scale = 0	
	
func _integrate_forces(_state):
	linear_velocity = _constant_velocity

func __on_initial_velocity_set(direction: Vector2, speed: float):
	linear_damp = false
	_constant_velocity = direction*speed
