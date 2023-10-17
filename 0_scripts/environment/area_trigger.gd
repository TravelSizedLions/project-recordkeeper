extends Area2D
class_name AreaTrigger

@export var trigger_every_time: bool = false
@export var trigger_delay_seconds: float = 0
var __already_triggered: bool = false

func _ready():
	collision_mask = CollisionLayer.PlayerCharacter

func on_body_entered(body):
	if N.get_child(body, Player) && (not __already_triggered or trigger_every_time):
		__already_triggered = true
		get_tree().create_timer(trigger_delay_seconds).timeout.connect(__propagate)

func __propagate():
	propagate_call("trigger")
