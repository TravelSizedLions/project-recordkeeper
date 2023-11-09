extends State
class_name JaredDoubleJumpStartingState

@onready var player: Player = get_tree().get_first_node_in_group('player')

func __on_physics_process(_delta: float):
	player.handle_run()
	if player.is_falling():
		transitioner.emit(JaredDoubleJumpFallingState)
	
	# test for jump buffering
	player.pressed_jump()

func __on_enter():
	player.velocity.y = player.settings.jump_force
	player.animator.play('double_jump_start')
	
func __on_animation_finished():
	if player.animator.animation != 'rising':
		player.animator.play('rising')
