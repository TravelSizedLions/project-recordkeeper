extends HealthBar
class_name JaredHealthBar

func __on_connect_to_player(player: Player):
	player.jared_current_health_update.connect(_update_health)
	player.jared_max_health_update.connect(_update_max_health)
