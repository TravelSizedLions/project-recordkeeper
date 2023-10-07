extends ProjectileOnHitBehavior
class_name FloatAwayOnHitBehavior

func on_hit(body):
	var attribute: CanFloatAway = NodeUtils.get_child(body.owner, CanFloatAway)
	if attribute:
		attribute.apply_attribute()

