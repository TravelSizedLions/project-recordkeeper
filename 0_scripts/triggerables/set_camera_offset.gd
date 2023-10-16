extends Triggerable
class_name SetCameraOffset

@export var __offset: Vector2
@export var __duration: float = .5

func _on_trigger():
	var camera = N.find(Camera2D)
	create_tween()\
		.tween_property(camera, "offset", __offset, __duration)\
		.set_ease(Tween.EASE_IN_OUT)\
		.set_trans(Tween.TRANS_SINE)
