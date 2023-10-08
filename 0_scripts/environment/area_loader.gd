extends Node2D
class_name AreaLoader

## The scene that will load when there isn't already one loaded.
@export var default_area: PackedScene

var current_area: PackedScene

func _ready():
	if get_child_count() > 0:
		current_area = load(get_child(0).scene_file_path)
		for child in get_children():
			child.queue_free()
	else:
		current_area = default_area

	reload()

func reload():
	var children = get_children()
	var freed = []

	for child in children:
		remove_child(child)
		freed.append(child)
	
	for child in freed:
		child.queue_free()

	var reloaded: Node = current_area.instantiate()
	add_child(reloaded)
