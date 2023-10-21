extends Triggerable
class_name KickCameraTrigger

@export var duration: float = .5
@export var from_zoom: float = .8

func _on_trigger():
	var cam: Camera2D = TreeAccess.tree.get_first_node_in_group('camera')
	if cam:
		var kicker: CameraKicker = N.get_child(cam, CameraKicker)
		if kicker:
			kicker.kick(duration, from_zoom)
