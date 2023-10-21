extends Node
class_name CameraKicker

var __kicking: bool
var __from_zoom: Vector2
var __timer: float

var __orig_zoom: Vector2

@onready var cam: Camera2D = N.get_ancestor(self, Camera2D)

func _process(delta):
	if __kicking:
		handle_kick(delta)
		
func handle_kick(delta):
	__timer -= delta
	if __timer > 0:
		var t = ease(__timer, -3)
		cam.zoom = (t)*__from_zoom +(1-t)*__orig_zoom
	else:
		cam.zoom = __orig_zoom
		__kicking = false


func kick(duration: float, from_zoom: float):
	__from_zoom = Vector2(from_zoom, from_zoom)
	__orig_zoom = cam.zoom
	__timer = duration
	__kicking = true
