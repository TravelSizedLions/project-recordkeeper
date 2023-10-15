@tool
extends Node2D
class_name CircleGizmo

@export var radius: float = 8
@export var color: Color = Color.WHITE
@export var stroke_width: float = .1

func _draw():
	if Engine.is_editor_hint():
		draw_arc(Vector2.ZERO, radius, 0, TAU, 36, color, stroke_width, true)
	
