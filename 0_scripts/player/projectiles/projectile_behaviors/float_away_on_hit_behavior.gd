extends ProjectileOnHitBehavior
class_name FloatAwayOnHitBehavior

func on_hit(body):
	# TODO: If the projectile hits the floor, the body owner is the scene root, 
	# so this will just find the first instance of CanFloatAway anywhere in the scene...
	var enemy: Enemy = N.get_ancestor(body, Enemy)
	print(enemy)
	if enemy:
		var attribute: CanFloatAway = N.get_child(enemy, CanFloatAway)
		if attribute:
			attribute.apply_attribute()

