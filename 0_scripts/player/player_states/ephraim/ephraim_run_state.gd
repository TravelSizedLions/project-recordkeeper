extends State
class_name EphraimRunState

@onready var player: Player = get_tree().get_first_node_in_group('player')

func __on_physics_process(_delta: float):
	player.handle_run()
	if not player.is_moving():
		transitioner.emit(EphraimIdleState)
	elif player.pressed_jump():
		transitioner.emit(EphraimStartJumpState)
	elif player.is_falling():
		player.set_new_fall_spawnpoint()
		transitioner.emit(EphraimFallingState)
	elif player.pressed_swap():
		transitioner.emit(EphraimSwapOutState)

func __on_enter():
	player.animator.play('run')

