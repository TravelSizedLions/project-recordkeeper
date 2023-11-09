extends State
class_name JaredRisingState

@onready var player: Player = get_tree().get_first_node_in_group('player')

func __on_physics_process(_delta: float):
	player.handle_run()
	if player.is_falling():
		transitioner.emit(JaredFallingState)
	elif player.pressed_jump(true):
		transitioner.emit(JaredDoubleJumpStartingState)

func __on_enter():
	player.animator.play('rising')
