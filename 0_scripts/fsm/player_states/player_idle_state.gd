extends State
class_name PlayerIdleState

var player: Player = null

func __on_ready():
	player = get_tree().get_first_node_in_group('player')

func __on_physics_process(_delta: float):
	if Input.get_axis('left', 'right'):
		transitioner.emit(PlayerRunState)
	elif Input.is_action_just_pressed("jump"):
		transitioner.emit(PlayerJumpState)

func __on_enter():
	player.animator.play('idle')

