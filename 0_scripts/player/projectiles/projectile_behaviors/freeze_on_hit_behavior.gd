extends ProjectileOnHitBehavior
class_name FreezeOnHitBehavior

var __applied: bool = false

func on_hit(body):
	if not __applied:
		freeze_projectile(body)

func freeze_projectile(body):
	self.projectile.set_linear_velocity(Vector2.ZERO)
	self.projectile.freeze = true 
	self.projectile.lock_rotation = true
	
	var collider: CollisionShape2D = N.get_child(projectile, CollisionShape2D)
	if collider:
		collider.disabled = true
	
	# Detach projectile from its current parent and attach it
	# to whatever it hit.
	var pos = self.projectile.global_position
	var parent = self.projectile.get_parent()
	if parent:
		__applied = true
		parent.remove_child(self.projectile)
	
#	if not body.is_ancestor_of(projectile) and not projectile.is_ancestor_of(body):
	prints('adding self to', body)
	body.add_child(self.projectile)
	body.move_child(self.projectile, 0)
	self.projectile.global_position = pos
	set_owner(body)


func is_applied():
	return __applied
