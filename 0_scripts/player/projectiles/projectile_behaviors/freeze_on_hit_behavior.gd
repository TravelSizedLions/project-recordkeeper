extends ProjectileOnHitBehavior
class_name FreezeOnHitBehavior

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
		var pos = self.projectile.global_position
		parent.remove_child(self.projectile)
		if not body.is_ancestor_of(projectile) and not projectile.is_ancestor_of(body):
			body.add_child(self.projectile)
			body.move_child(self.projectile, 0)
			self.projectile.global_position = pos
			set_owner(body)

