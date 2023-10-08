extends EnemyAttribute
class_name HasGravity

@onready var enemy: Enemy = owner

func _physics_process(delta):
	CharUtils.apply_gravity(enemy, delta)
	enemy.move_and_slide()

func apply_attribute():
	pass
