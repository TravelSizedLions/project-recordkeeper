extends ProjectileOnHitBehavior
class_name CausesDamageOnHitBehavior

@export var damage: float = 1

var caused_damage_already: bool = false

func on_hit(body):
	var health_attr: HasEnemyHealthBar = N.get_child(body, HasEnemyHealthBar)
	if health_attr and not caused_damage_already:
		health_attr.take_damage(damage)
		caused_damage_already = true
