extends ProjectileOnHitBehavior
class_name FreezeOnContact

func on_hit(body):
	freeze_projectile(body)

func freeze_projectile(body):
	self.projectile.set_linear_velocity(Vector2.ZERO)
	self.projectile.freeze = true 
	self.projectile.lock_rotation = true
	
	var collider: CollisionShape2D = get_node('../collision_shape_2d')
	collider.queue_free()
	
	var parent = self.projectile.get_parent()
	if parent:
		parent.remove_child(self.projectile)
		body.add_child(self.projectile)
		body.move_child(self.projectile, 0)
		set_owner(body)

