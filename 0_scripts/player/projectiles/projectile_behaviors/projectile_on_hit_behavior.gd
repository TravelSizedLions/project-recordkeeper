extends Node2D
class_name ProjectileOnHitBehavior

var projectile: Projectile

func _enter_tree():
	projectile = get_parent()
	projectile.register_behavior(self)

func on_hit(_body):
	pass
