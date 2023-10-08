extends Enemy
class_name Isolith

## How quickly the enemy moves (in .1 pixel/second increments)
@export var move_speed: float = -400

func _physics_process(delta):
	if _enabled:
		velocity.x = move_speed*delta
		move_and_slide()

func __on_disabled():
	for col in N.get_all_children(self, CollisionShape2D):
		col.set_deferred('disabled', true)
		
func __on_enabled():
	for col in N.get_all_children(self, CollisionShape2D):
		col.set_deferred('disabled', false)
