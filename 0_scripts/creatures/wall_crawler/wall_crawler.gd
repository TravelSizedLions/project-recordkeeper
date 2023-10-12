extends Enemy
class_name WallCrawler

## How quickly the enemy moves (in .1 pixel/second increments)
@export var move_speed: float = -400

@onready var charbody = N.get_child(self, CharacterBody2D)

func _physics_process(delta):
	if _enabled:
		charbody.velocity.x = move_speed*delta
		charbody.move_and_slide()

func __on_disabled():
	for col in N.get_all_children(self, CollisionShape2D):
		col.set_deferred('disabled', true)
		
func __on_enabled():
	for col in N.get_all_children(self, CollisionShape2D):
		col.set_deferred('disabled', false)
