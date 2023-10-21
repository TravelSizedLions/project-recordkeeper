extends Triggerable
class_name AnimationTrigger

@export var animation_to_play: String

func _on_trigger():
	var animator = N.get_child(self, AnimatedSprite2D)
	if animator:
		animator.modulate = Color.WHITE
		animator.play(animation_to_play)
