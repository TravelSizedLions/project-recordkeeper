extends State
class_name EphraimSwapOutState

@onready var player: Player = get_tree().get_first_node_in_group('player')

func __on_enter():
	player.swap_player()
