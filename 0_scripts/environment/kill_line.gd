extends Area2D
class_name KillLine

func _ready():
	self.collision_layer = CollisionLayer.Auxiliary
	self.collision_mask = CollisionLayer.Player

func on_body_entered(body):
	var player: Player = N.get_ancestor(body, Player)
	if player:
		player.handle_fall()
