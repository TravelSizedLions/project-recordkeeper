extends State
class_name PlayerFallingState

@onready var player: Player = get_tree().get_first_node_in_group('player')

func __on_physics_process(_delta: float):
	player.handle_run()
	if player.is_on_floor():
		transitioner.emit(PlayerLandingState)

func __on_enter():
	player.animator.play('falling')
