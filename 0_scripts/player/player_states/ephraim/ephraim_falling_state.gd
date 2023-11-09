extends State
class_name EphraimFallingState

@onready var player: Player = get_tree().get_first_node_in_group('player')

func __on_physics_process(_delta: float):
	player.handle_run()
	if player.is_on_floor():
		transitioner.emit(EphraimLandingState)
	if player.pressed_jump() and player.in_coyote_time():
		transitioner.emit(EphraimStartJumpState)

func __on_enter():
	player.animator.play('falling')
