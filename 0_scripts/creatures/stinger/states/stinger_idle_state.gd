extends State
class_name StingerIdleState

@onready var stinger: Stinger = owner

func __on_physics_process(delta):
	stinger.decelerate(delta)
	if stinger.should_follow_player():
		transitioner.emit(StingerFollowState)