extends State
class_name PlayerRunState

var player: Player = null

func __on_ready():
	player = get_tree().get_first_node_in_group('player')

func __on_process(_delta: float):
	player.update_direction()

func __on_physics_process(_delta: float):
	var direction = Input.get_axis('left', 'right')
	if direction:
		player.velocity.x = direction * player.speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)
		if player.velocity.x < 0.2:
			transitioner.emit(PlayerIdleState)

func __on_enter():
	player.animator.play('run')

