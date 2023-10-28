extends	ProgressBar
class_name HealthBar

@export var normal_color: Color = Color.WHITE
@export var half_health: Color = Color.ORANGE
@export var danger_color: Color = Color.RED

func _ready():
	show_percentage = false
	rounded = true

func connect_to_entity(entity):
	__on_connect_to_entity(entity)

func __on_connect_to_entity(_entity):
	pass

func _update_health(v: float):
	value = v
	if value == 1:
		self.modulate = danger_color
	elif value/max_value < 0.5:
		self.modulate = half_health
	else:
		self.modulate = normal_color

func _update_max_health(v: float):
	max_value = v
	if value == 1:
		self.modulate = danger_color
	elif value/max_value < 0.5:
		self.modulate = half_health
	else:
		self.modulate = normal_color
