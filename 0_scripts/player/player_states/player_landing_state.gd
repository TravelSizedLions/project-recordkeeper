extends State
class_name PlayerLandingState

@onready var player: Player = get_tree().get_first_node_in_group('player')

func __on_physics_process(_delta: float):
	player.handle_run()
	if player.is_moving():
		transitioner.emit(PlayerRunState)
	elif player.pressed_jump():
		transitioner.emit(PlayerStartJumpState)

func __on_enter():
	player.animator.play('land')

func __on_animation_finished():
	transitioner.emit(PlayerIdleState)
