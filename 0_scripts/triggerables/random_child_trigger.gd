class_name RandomChildTrigger extends Triggerable

func _on_trigger():
	N.get_all_children(self, Triggerable, false)\
		.pick_random()\
		.trigger()
