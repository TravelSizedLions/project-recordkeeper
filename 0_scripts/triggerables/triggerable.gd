extends Node2D
class_name Triggerable

static var _enabled: bool = true

func trigger():
	if _enabled:
		_on_trigger()
	
func _on_trigger():
	pass


static func disable_triggers():
	_enabled = false

static func enable_triggers():
	_enabled = true
