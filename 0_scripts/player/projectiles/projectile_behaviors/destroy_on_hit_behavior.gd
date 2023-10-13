extends ProjectileOnHitBehavior
class_name DestroySelfOnHitBehavior

func on_hit(body):
	projectile.queue_free()
