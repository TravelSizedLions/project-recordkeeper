class_name ShowHideToggle extends Toggleable

@export var thing_to_hide: CanvasItem
@export var tween_speed_seconds: float = .5

# Called when the node enters the scene tree for the first time.
func _on_toggled_on():
	create_tween()\
	.tween_property(thing_to_hide, 'modulate:a', 1.0, tween_speed_seconds)\
	.set_trans(Tween.TRANS_SINE)\
	.set_ease(Tween.EASE_IN_OUT)

	
func _on_toggled_off():
	create_tween()\
	.tween_property(thing_to_hide, 'modulate:a', 0, tween_speed_seconds)\
	.set_trans(Tween.TRANS_SINE)\
	.set_ease(Tween.EASE_IN_OUT)


	
