extends Area2D
class_name AreaTrigger

@export var trigger_every_time: bool = false

var __already_triggered: bool = false

func _ready():
	collision_mask = CollisionLayer.PlayerCharacter

func on_body_entered(body):
	if N.get_child(body, Player) && (not __already_triggered or trigger_every_time):
		propagate_call("trigger")
		__already_triggered = true
