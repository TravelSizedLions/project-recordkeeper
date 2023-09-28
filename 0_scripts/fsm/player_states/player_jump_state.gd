extends State
class_name PlayerJumpState

@onready var player: Player = get_tree().get_first_node_in_group('player')

func __on_physics_process(_delta: float):
	if player.animator.animation == 'rising' && player.velocity.y > 0:
		player.animator.play('falling')

	if player.animator.animation == 'falling' and player.is_on_floor():
		player.animator.play('land')

func __on_enter():
	player.animator.play('jump_start')
	
func __on_exit():
	pass

func __on_animation_finished():
	if player.animator.animation == 'jump_start':
		player.animator.play('rising')
		player.velocity.y = player.jump_force
	elif player.animator.animation == 'land':
		transitioner.emit(PlayerIdleState)
