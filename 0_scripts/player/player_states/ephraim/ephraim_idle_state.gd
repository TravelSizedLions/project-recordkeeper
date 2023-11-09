extends State
class_name EphraimIdleState

@onready var player: Player = get_tree().get_first_node_in_group('player')

func __on_physics_process(_delta: float):
	if player.pressed_move():
		transitioner.emit(EphraimRunState)
	elif player.pressed_jump():
		player.set_new_fall_spawnpoint()
		transitioner.emit(EphraimStartJumpState)
	elif player.is_falling():
		player.set_new_fall_spawnpoint()
		player.start_coyote_time()
		transitioner.emit(EphraimFallingState)
	elif player.pressed_swap():
		transitioner.emit(EphraimSwapOutState)

func __on_enter():
	player.animator.play('idle')

