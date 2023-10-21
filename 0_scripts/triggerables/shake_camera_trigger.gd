extends Triggerable
class_name ShakeCameraTrigger

@export var duration: float = .5
@export var intensity: float = 4

func _on_trigger():
	var cam: Camera2D = get_tree().get_first_node_in_group('camera')
	if cam:
		var shaker: Shaker = N.get_ancestor(cam, Shaker)
		if shaker:
			shaker.shake(duration, intensity)
