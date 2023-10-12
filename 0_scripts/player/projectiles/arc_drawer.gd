extends Node2D
class_name ArcDrawer

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var fixedDelta = 1.0/Engine.physics_ticks_per_second

## The thing to draw the arc with. Should be a sprite with an area attached to it
@export var arcdot: PackedScene

@export var distance_between_marks = 4

var max_marks = 20

var _arcdots: Array = []

func predict_arc(from: Vector2, velocity: Vector2):
	clear_arc()
	var current_position = from

	for i in range(max_marks):
		current_position += velocity*fixedDelta*distance_between_marks
		velocity.y += gravity*fixedDelta*distance_between_marks
		var current_dot = N.create_scene(arcdot)
		current_dot.position = current_position
		_arcdots.append(current_dot)
		
		var area: Area2D = N.get_child(_arcdots[-1], Area2D)
		if area.has_overlapping_areas() || area.has_overlapping_bodies():
			break


func clear_arc():
	for dot in _arcdots:
		dot.queue_free()

	_arcdots.clear()
