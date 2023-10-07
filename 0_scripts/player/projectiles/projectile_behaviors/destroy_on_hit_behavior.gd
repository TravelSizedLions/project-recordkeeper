extends ProjectileOnHitBehavior
class_name DestroySelfOnHitBehavior

func on_hit(_body):
	self.projectile.queue_free()
