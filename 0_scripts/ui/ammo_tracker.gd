extends Label
class_name AmmoTracker

func connect_to_entity(entity):
	var launcher: ChargeLauncher = N.get_child(entity, ChargeLauncher)
	if launcher:
		launcher.on_update_capacity.connect(__update)

func __update(current: int, maximum: int):
	text = '%s/%s' % [current, maximum]
