extends CollisionObject2D
class_name Enemy

@export var _enabled: bool = true

func _enter_tree():
	if collision_layer == CollisionLayer.Default:
		collision_layer = CollisionLayer.Enemies
	
	if collision_mask == CollisionLayer.Default:
		collision_mask = CollisionLayer.Default | CollisionLayer.Projectiles
	__on_tree_entered()

func disable():
	_enabled = false
	__on_disabled()

func enable():
	_enabled = true
	__on_enabled()

func __on_tree_entered():
	pass

func __on_disabled():
	pass

func __on_enabled():
	pass
