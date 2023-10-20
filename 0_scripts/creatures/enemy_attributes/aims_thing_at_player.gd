extends Node2D
class_name AimsThingAtPlayer

@export var thing_to_aim: Node2D
@onready var player: Player = Player.retrieve()

func _physics_process(_delta):
	if has_player():
		thing_to_aim.global_rotation = (player.global_position - thing_to_aim.global_position).angle()

func has_player():
	if player:
		return true
	
	player = Player.retrieve()
	return player != null
