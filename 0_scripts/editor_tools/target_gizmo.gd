@tool
extends Node2D
class_name TargetGizmo

@export var radius: float = 4
@export var color: Color = Color.WHITE
@export var stroke_width: float = .25

func _draw():
	if Engine.is_editor_hint():
		var vstart = Vector2.UP*radius
		var vend = Vector2.DOWN*radius
		var hstart = Vector2.LEFT*radius
		var hend = Vector2.RIGHT*radius
		draw_line(vstart, vend, color, stroke_width, true)
		draw_line(hstart, hend, color, stroke_width, true)

