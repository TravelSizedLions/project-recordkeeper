extends State
class_name CommunityCrabFollowState

@onready var crab: CommunityCrab = owner
@onready var player = get_tree().get_first_node_in_group('player')

func __on_physics_process(delta: float):
	if not crab.should_follow_player():
		crab.velocity.x = 0
		transitioner.emit(CommunityCrabIdleState)
	else:
		crab.move_towards_player(delta)

func __on_enter():
	crab.animator.play('follow')
