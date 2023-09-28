extends State
class_name PlayerRunState

@onready var player: Player = get_tree().get_first_node_in_group('player')

func __on_physics_process(_delta: float):
	player.handle_run()
	if not player.is_moving():
		transitioner.emit(PlayerIdleState)
	elif player.pressed_jump():
		transitioner.emit(PlayerStartJumpState)

func __on_enter():
	player.animator.play('run')

