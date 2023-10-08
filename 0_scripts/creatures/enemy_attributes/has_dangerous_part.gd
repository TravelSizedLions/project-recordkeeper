extends EnemyAttribute
class_name HasDangerousPart

func apply_attribute():
	var player: Player = get_tree().get_first_node_in_group('player')
	player.take_damage(1)

func on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	var player: Player = get_tree().get_first_node_in_group('player')
	if body == player:
		apply_attribute()
