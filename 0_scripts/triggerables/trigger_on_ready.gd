class_name TriggerOnReady extends Node

@export var trigger: Triggerable

func _ready():
	if trigger:
		trigger.trigger()
	else:
		self.get_child(0).trigger()
