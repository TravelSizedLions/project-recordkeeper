extends HealthBar
class_name EnemyHealthBar

func __on_connect_to_entity(entity):
	var health_attr: EnemyHealthBarPosition = N.get_child(entity, EnemyHealthBarPosition)
	health_attr.health_update.connect(_update_health)
	health_attr.max_health_update.connect(_update_max_health)
