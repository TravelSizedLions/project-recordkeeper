extends ProjectileOnHitBehavior
class_name DestroyOnHitBehavior

func on_hit(_body):
	self.projectile.queue_free()
