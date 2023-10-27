extends CollisionObject2D
class_name Enemy

@export var _enabled: bool = true

signal destroyed

func _enter_tree():
	if collision_layer == CollisionLayer.Default:
		collision_layer = CollisionLayer.Enemies
	
	if collision_mask == CollisionLayer.Default:
		collision_mask = CollisionLayer.Default | CollisionLayer.Projectiles
	__on_tree_entered()

func _exit_tree():
	destroyed.emit(self)
	__on_tree_exited()

func disable():
	_enabled = false
	for c in N.get_all_children(self, CollisionShape2D):
		c.disabled = true
	
	for e in N.get_all_children(self, ProjectileEmitter):
		e.disable()
	
	__on_disabled()

func enable():
	_enabled = true
	for c in N.get_all_children(self, CollisionShape2D):
		c.disabled = false
	
	for e in N.get_all_children(self, ProjectileEmitter):
		e.enable()
	
	__on_enabled()

func __on_tree_entered():
	pass

func __on_disabled():
	pass

func __on_enabled():
	pass

func __on_tree_exited():
	pass
