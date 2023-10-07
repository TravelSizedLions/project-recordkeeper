extends	ProgressBar
class_name HealthBar

func _ready():
	show_percentage = false
	rounded = true

func connect_to_player(player: Player):
	print('connecting to player: ', self)
	__on_connect_to_player(player)

func __on_connect_to_player(_player: Player):
	pass

func _update_health(v: float):
	value = v

func _update_max_health(v: float):
	max_value = v
