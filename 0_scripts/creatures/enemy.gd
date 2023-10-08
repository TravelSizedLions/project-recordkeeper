extends CharacterBody2D
class_name Enemy

@export var _enabled: bool = true

func disable():
	_enabled = false
	__on_disabled()

func enable():
	_enabled = true
	__on_enabled()

func __on_disabled():
	pass

func __on_enabled():
	pass
