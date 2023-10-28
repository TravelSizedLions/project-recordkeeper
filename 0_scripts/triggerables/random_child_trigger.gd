class_name RandomChildTrigger extends Triggerable

func _on_trigger():
	var children: Array = N.get_all_children(self, Triggerable, false)
	var rng = RandomNumberGenerator.new()
	children[rng.randi_range(0, children.size()-1)].trigger()
