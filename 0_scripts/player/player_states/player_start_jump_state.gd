extends State
class_name PlayerStartJumpState

@onready var player: Player = get_tree().get_first_node_in_group('player')

func __on_physics_process(_delta: float):
	player.handle_run()
	
func __on_enter():
	player.animator.play('jump_start')

func __on_animation_finished():
	player.velocity.y = player.jump_force
	transitioner.emit(PlayerRisingState)
