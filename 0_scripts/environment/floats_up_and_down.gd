class_name FloatsUpAndDown extends Node2D

@export var frequency: float = 5
@export var amplitude: float = 20
var starting_position: Vector2

func _enter_tree():
	starting_position = global_position
	__start_offset()

func __start_offset():
	var rng = RandomNumberGenerator.new()
	var offset = rng.randf()
	self.create_tween()\
		.tween_property(self, 'global_position:y', starting_position.y-(offset*(amplitude/2)), (offset*frequency/2))\
		.set_ease(Tween.EASE_IN_OUT)\
		.set_trans(Tween.TRANS_SINE)\
		.finished.connect(__float_down)
	
func __float_up():
	self.create_tween()\
		.tween_property(self, 'global_position:y', starting_position.y-amplitude/2, frequency/2)\
		.set_ease(Tween.EASE_IN_OUT)\
		.set_trans(Tween.TRANS_SINE)\
		.finished.connect(__float_down)
	
func __float_down():
	self.create_tween()\
		.tween_property(self, 'global_position:y', starting_position.y+amplitude/2, frequency/2)\
		.set_ease(Tween.EASE_IN_OUT)\
		.set_trans(Tween.TRANS_SINE)\
		.finished.connect(__float_up)
