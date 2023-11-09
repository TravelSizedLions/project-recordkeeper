extends State
class_name JaredFallingState

@onready var player: Player = get_tree().get_first_node_in_group('player')

func __on_physics_process(_delta: float):
	player.handle_run()
	if player.is_on_floor():
		transitioner.emit(JaredLandingState)
	if player.pressed_jump(true):
		if player.in_coyote_time():
			transitioner.emit(JaredStartJumpState)
		else:
			transitioner.emit(JaredDoubleJumpStartingState)

func __on_enter():
	player.animator.play('falling')
