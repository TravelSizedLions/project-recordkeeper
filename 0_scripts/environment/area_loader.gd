extends Node2D
class_name AreaLoader

@export var transition: ScreenTransition

## The scene that will load when there isn't already one loaded.
@export var default_area: PackedScene
var current_area: PackedScene

signal on_finished_load

func _ready():
	if get_child_count() > 0:
		current_area = load(get_child(0).scene_file_path)
	else:
		current_area = default_area

	transition.on_loading_start.connect(reload)
	transition.transition_to_loading()

func load_new_area(path_to_scene: String):
	current_area = load(path_to_scene)
	transition.transition_to_loading()

func reload():
	if current_area:
		var children = get_children()

		var root = get_tree().root
		for p in N.get_all_children(root, Projectile):
			p.queue_free()

		for e in N.get_all_children(root, Enemy):
			e.queue_free()

		for c in children:
			c.queue_free()

		var reloaded: Node = current_area.instantiate()
		add_child(reloaded)
		
		transition.transition_from_loading()
		on_finished_load.emit()

