@tool
extends Node2D
class_name TGizmo

@export var radius: float = 8
@export var color: Color = Color.GREEN
@export var stroke_width: float = .5

func _draw():
	if Engine.is_editor_hint():
		var vstart = Vector2.UP*radius*2
		var vend = Vector2.ZERO
		var hstart = Vector2.LEFT*radius
		var hend = Vector2.RIGHT*radius
		draw_line(vstart, vend, color, stroke_width, true)
		draw_line(hstart, hend, color, stroke_width, true)

