extends	ProgressBar
class_name HealthBar

func _ready():
	show_percentage = false
	rounded = true

func connect_to_entity(entity):
	__on_connect_to_entity(entity)

func __on_connect_to_entity(_entity):
	pass

func _update_health(v: float):
	value = v

func _update_max_health(v: float):
	max_value = v
