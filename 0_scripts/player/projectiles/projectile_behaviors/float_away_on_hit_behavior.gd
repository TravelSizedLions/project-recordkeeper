extends ProjectileOnHitBehavior
class_name FloatAwayOnHitBehavior

func on_hit(body):
	var enemy: Enemy = N.get_ancestor(body, Enemy)
	if enemy:
		var attribute: CanFloatAway = N.get_child(enemy, CanFloatAway)
		if attribute:
			attribute.apply_attribute()

