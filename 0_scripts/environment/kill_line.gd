extends Area2D
class_name KillLine


func on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	print('kill line hit (body shape entered)')
	var player: Player = N.get_ancestor(body, Player)
	if player:
		player.die()


func on_body_entered(body):
	print('kill line hit (body entered)')
	var player: Player = N.get_ancestor(body, Player)
	if player:
		player.die()
