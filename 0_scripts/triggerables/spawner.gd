extends Triggerable
class_name  Spawner

@export var __thing_to_spawn: PackedScene

## Spawn as a child of the root scene.
@export var __parent: Node

func _on_trigger():
	call_deferred('spawn')
	
func spawn():
	if not __parent:
		var instance = N.create_scene(__thing_to_spawn)
		if "global_position" in instance:
			instance.global_position = global_position
	else:
		N.create_scene(__thing_to_spawn, __parent)
