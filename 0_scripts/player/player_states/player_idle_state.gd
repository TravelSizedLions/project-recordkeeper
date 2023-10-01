extends State
class_name PlayerIdleState

@onready var player: Player = get_tree().get_first_node_in_group('player')

func __on_physics_process(_delta: float):
	if player.pressed_move():
		transitioner.emit(PlayerRunState)
	elif player.pressed_jump():
		transitioner.emit(PlayerStartJumpState)
	elif player.is_falling():
		transitioner.emit(PlayerFallingState)

func __on_enter():
	player.animator.play('idle')

