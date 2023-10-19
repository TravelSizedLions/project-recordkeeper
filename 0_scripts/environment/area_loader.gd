extends Node2D
class_name AreaLoader

## The scene that will load when there isn't already one loaded.
@export var default_area: PackedScene

var current_area: PackedScene

func _ready():
	if get_child_count() > 0:
		current_area = load(get_child(0).scene_file_path)
	else:
		current_area = default_area

	reload()

func load_new_area(area: PackedScene):
	current_area = area
	reload()

func reload():
	if current_area:
		var children = get_children()
		SoundManager.stop_music()

		var root = get_tree().root
		for p in N.get_all_children(root, Projectile):
			p.queue_free()

		for e in N.get_all_children(root, Enemy):
			e.queue_free()

		for c in children:
			c.queue_free()

	#	Triggerable.disable_triggers()
		call_deferred('__after_reload')

func __after_reload():
	var reloaded: Node = current_area.instantiate()
	add_child(reloaded)
#	get_tree().create_timer(3).timeout.connect(Triggerable.enable_triggers)
