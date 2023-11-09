extends State
class_name JaredRunState

@onready var player: Player = get_tree().get_first_node_in_group('player')

func __on_physics_process(_delta: float):
	player.handle_run()
	if not player.is_moving():
		transitioner.emit(JaredIdleState)
	elif player.pressed_jump():
		player.set_new_fall_spawnpoint()
		transitioner.emit(JaredStartJumpState)
	elif player.is_falling():
		player.start_coyote_time()
		player.set_new_fall_spawnpoint()
		transitioner.emit(JaredFallingState)
	elif player.pressed_swap():
		transitioner.emit(JaredSwapOutState)

func __on_enter():
	player.animator.play('run')

