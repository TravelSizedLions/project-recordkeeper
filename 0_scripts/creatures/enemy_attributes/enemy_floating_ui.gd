extends Node2D
class_name EnemyFloatingUI

var __entity

func _process(_delta):
	if not __entity:
		queue_free()

func connect_to_entity(entity):
	__entity = entity
	var health_root: EnemyHealthBarPosition = N.get_child(entity, EnemyHealthBarPosition)
	if health_root:
		health_root.position_updated.connect(__update_position)
		health_root.entity_destroyed.connect(self.queue_free)

func __update_position(pos: Vector2):
	global_position = pos
	
