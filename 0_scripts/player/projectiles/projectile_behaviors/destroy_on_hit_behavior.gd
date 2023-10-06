extends ProjectileOnHitBehavior
class_name DestroyOnContact

func on_hit(_body):
	self.projectile.queue_free()
