extends Enemy
class_name WallCrawler

## How quickly the enemy moves (in .1 pixel/second increments)
@export var move_speed: float = -400
@export var trigger_distance = 1000

@onready var charbody = N.get_child(self, CharacterBody2D)

var __start_moving: bool = false

func _ready():
	var trigger_col: CollisionShape2D = N.get_child($trigger_distance, CollisionShape2D)
	var shape: CircleShape2D = trigger_col.shape
	shape.radius = trigger_distance

func _physics_process(delta):
	if _enabled and __start_moving:
		charbody.velocity.x = move_speed*delta
		charbody.move_and_slide()

func __on_disabled():
	for col in N.get_all_children(self, CollisionShape2D):
		col.set_deferred('disabled', true)
		
func __on_enabled():
	for col in N.get_all_children(self, CollisionShape2D):
		col.set_deferred('disabled', false)


func on_trigger_distance_body_entered(body):
	var player = N.get_child(body, Player)
	if player:
		__start_moving = true
		

