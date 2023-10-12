extends Node2D
class_name GravitatesTowardsPlayer

## how quickly the enemy accelerates towards the player (in .1 pixels/sec^2)
@export var gravitation_speed = 250
@export var max_speed = 800

@onready var enemy: Enemy = owner
@onready var player: Player = Player.retrieve()


func _physics_process(delta):
	var dir = (player.global_position - enemy.global_position).normalized()
	var grav = dir*gravitation_speed*delta
	
	enemy.velocity += grav
	if enemy.velocity.length() > max_speed:
		enemy.velocity = enemy.velocity.normalized()*max_speed

	enemy.move_and_slide()

