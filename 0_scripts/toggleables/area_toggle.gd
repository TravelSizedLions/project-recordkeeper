class_name AreaToggle extends Area2D

@export var start_on: bool = false
@export var toggle_on_delay_seconds: float = 0
@export var toggle_off_delay_seconds: float = 0

func _ready():
	collision_mask = CollisionLayer.PlayerCharacter
	if start_on:
		__propagate_on()
	else:
		__propagate_off()

func __propagate_on():
	propagate_call("toggle_on")

func __propagate_off():
	propagate_call("toggle_off")


func on_body_entered(body):
	if N.get_child(body, Player):
		prints('toggling on!')
		get_tree().create_timer(toggle_on_delay_seconds).timeout.connect(__propagate_on)

func on_body_exited(body):
	if N.get_child(body, Player):
		prints('toggling off!')
		get_tree().create_timer(toggle_off_delay_seconds).timeout.connect(__propagate_off)

