extends ProjectileOnHitBehavior
class_name FloatAwayOnHitBehavior

func on_hit(body):
	# TODO: If the projectile hits the floor, the body owner is the scene root, 
	# so this will just find the first instance of CanFloatAway anywhere in the scene...
	var attribute: CanFloatAway = NodeUtils.get_child(body.owner, CanFloatAway)
	if attribute:
		attribute.apply_attribute()

