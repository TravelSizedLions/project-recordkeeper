extends State
class_name StingerFollowState

@onready var stinger: Stinger = owner

func __on_physics_process(physicsDelta: float):
	if not stinger.should_follow_player():
		transitioner.emit(StingerIdleState)
	else:
		stinger.move_towards_player(physicsDelta)

func __on_enter():
	var shooter = N.get_child(stinger, ShootsAtPlayer)
	if shooter:
		shooter.enable()