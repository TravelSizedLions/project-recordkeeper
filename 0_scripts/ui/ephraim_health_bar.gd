extends HealthBar
class_name EphraimHealthBar

func __on_connect_to_entity(player: Player):
	player.ephraim_current_health_update.connect(_update_health)
	player.ephraim_max_health_update.connect(_update_max_health)
