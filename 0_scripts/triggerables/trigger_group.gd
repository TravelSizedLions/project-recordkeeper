class_name TriggerGroup extends Triggerable

func _on_trigger():
	for t in N.get_all_children(self, Triggerable, false):
		t.trigger()
