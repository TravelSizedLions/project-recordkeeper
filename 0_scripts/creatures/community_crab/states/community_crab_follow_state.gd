extends State
class_name CommunityCrabFollowState

@onready var crab: CommunityCrab = owner

func __on_physics_process(delta: float):
	if not crab.should_follow_player():
		crab.stop()
		transitioner.emit(CommunityCrabIdleState)
	else:
		crab.move_towards_player(delta)

func __on_enter():
	crab.animator.play('follow')
