extends EnemyAttribute
class_name HasGravity

@onready var enemy: CharacterBody2D = N.get_child(owner, CharacterBody2D)

func _physics_process(delta):
	CharUtils.apply_gravity(enemy, delta)
	enemy.move_and_slide()
