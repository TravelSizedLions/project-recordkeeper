extends Enemy
class_name Stinger

@onready var player: Player = Player.retrieve()
@onready var charbody: CharacterBody2D = N.get_child(self, CharacterBody2D)

@export var hard_acceleration = 800
@export var soft_acceleration = 400

@export var deceleration = 1200
@export var max_follow_speed = 20000
@export var min_follow_dist = 200
@export var max_follow_dist = 1000

func _ready():
	N.get_child(self, FSM).start()

func should_follow_player():
	if not _enabled:
		return false

	if global_position.y > player.global_position.y:
		return true
	
	var dist: float = (global_position - player.global_position).length()
	return dist > min_follow_dist and dist < max_follow_dist

func move_towards_player(physicsDelta: float):	
	var dir = global_position.direction_to(player.global_position).normalized()

	var v = charbody.velocity
	if abs(dir.x) < abs(dir.y):
		v = v + Vector2(dir.x*soft_acceleration, dir.y*hard_acceleration)*physicsDelta
	else:
		v = v + Vector2(dir.x*hard_acceleration, dir.y*soft_acceleration)*physicsDelta
	charbody.velocity = v

	if charbody.velocity.length() > max_follow_speed:
		charbody.velocity = charbody.velocity.normalized()*max_follow_speed
	
	charbody.move_and_slide()

func decelerate(physicsDelta):
	var speed = charbody.velocity.length()
	speed = clamp(speed - deceleration*physicsDelta, 0, max_follow_speed)
	charbody.velocity = charbody.velocity.normalized()*speed
	charbody.move_and_slide()
