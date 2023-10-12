extends Enemy
class_name CommunityCrab

@onready var player = get_tree().get_first_node_in_group('player')
@onready var animator = $animated_sprite_2d
@onready var charbody = N.get_child(self, CharacterBody2D)

@export var follow_speed = 10
@export var min_follow_dist = 100
@export var max_follow_dist = 500

func _process(_delta):
	if _enabled:
		CharUtils.update_facing(self)

func should_follow_player():
	if not _enabled:
		return false

	var dist = abs(position.x - player.position.x)
	return dist > min_follow_dist and dist < max_follow_dist

func move_towards_player(delta):
	var dir = position.direction_to(player.position).x
	if dir < 0:
		charbody.velocity.x = - follow_speed*delta
	else:
		charbody.velocity.x = follow_speed*delta
	charbody.move_and_slide()

func __on_disabled():
	for col in N.get_all_children(self, CollisionShape2D):
		col.set_deferred('disabled', true)
		
func __on_enabled():
	for col in N.get_all_children(self, CollisionShape2D):
		col.set_deferred('disabled', false)
