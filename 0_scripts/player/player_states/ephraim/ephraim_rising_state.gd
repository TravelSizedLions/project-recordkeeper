extends State
class_name EphraimRisingState

@onready var player: Player = get_tree().get_first_node_in_group('player')

func __on_physics_process(_delta: float):
	player.handle_run()
	if player.is_falling():
		transitioner.emit(EphraimFallingState)

func __on_enter():
	player.animator.play('rising')
