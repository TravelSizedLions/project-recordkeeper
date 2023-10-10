extends ProjectileOnHitBehavior
class_name DestroySelfOnHitPlayerBehavior

func on_hit(body):
	var player: Player = N.get_ancestor(body, Player)
	if player:
		print('destroying self: ', projectile)
		projectile.queue_free()
