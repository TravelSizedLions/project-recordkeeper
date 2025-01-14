extends State
class_name EphraimLandingState

@onready var player: Player = get_tree().get_first_node_in_group('player')

func __on_physics_process(_delta: float):
	player.handle_run()
	if player.is_moving():
		transitioner.emit(EphraimRunState)
	elif player.pressed_jump():
		player.set_new_fall_spawnpoint()
		transitioner.emit(EphraimStartJumpState)

func __on_enter():
	player.animator.play('land')

func __on_animation_finished():
	transitioner.emit(EphraimIdleState)
