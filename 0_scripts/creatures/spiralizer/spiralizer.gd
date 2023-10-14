extends Enemy
class_name Spiralizer

@export var override_rotation: bool = false
@export var min_rotation_speed: float
@export var max_rotation_speed: float

func _ready():
	if override_rotation:
		var rotator: RotatesRandomly = N.get_child(self, RotatesRandomly)
		if rotator:
			rotator.set_rotation_variation(min_rotation_speed, max_rotation_speed) 
