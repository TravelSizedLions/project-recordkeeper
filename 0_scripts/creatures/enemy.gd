extends CharacterBody2D
class_name Enemy

@export var _enabled: bool = true

func disable():
	_enabled = false

func enable():
	_enabled = true
