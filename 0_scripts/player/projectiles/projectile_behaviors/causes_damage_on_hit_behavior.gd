extends ProjectileOnHitBehavior
class_name CausesDamageOnHitBehavior

@export var damage: float = 1
@export var damage_player = true
@export var damage_enemy = false

var caused_damage_already: bool = false

func on_hit(body):
	var health_attr: HasEnemyHealthBar = N.get_child(body, HasEnemyHealthBar)
	if health_attr and not caused_damage_already:
		health_attr.take_damage(damage)
		caused_damage_already = true
	
	var player: Player = N.get_child(body, Player)
	if player and not caused_damage_already:
		player.take_damage(damage)
		caused_damage_already = true
