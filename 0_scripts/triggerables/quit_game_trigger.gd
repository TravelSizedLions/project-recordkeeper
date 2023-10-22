extends Triggerable
class_name QuitGameTrigger

func _on_trigger():
	get_tree().quit()
