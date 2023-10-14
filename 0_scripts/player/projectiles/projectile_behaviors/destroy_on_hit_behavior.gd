extends ProjectileOnHitBehavior
class_name DestroySelfOnHitBehavior

func on_hit(_body):
	projectile.queue_free()
