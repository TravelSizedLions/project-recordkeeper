extends State
class_name JaredRunState

@onready var player: Player = get_tree().get_first_node_in_group('player')

func __on_physics_process(_delta: float):
	player.handle_run()
	if not player.is_moving():
		transitioner.emit(JaredIdleState)
	elif player.pressed_jump():
		transitioner.emit(JaredStartJumpState)
	elif player.is_falling():
		transitioner.emit(JaredFallingState)
	elif player.pressed_swap():
		transitioner.emit(JaredSwapOutState)

func __on_enter():
	player.animator.play('run')

