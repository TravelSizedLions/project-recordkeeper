extends State
class_name CommunityCrabIdleState

@onready var crab: CommunityCrab = owner

func __on_physics_process(_delta: float):
	if crab.should_follow_player():
		transitioner.emit(CommunityCrabFollowState)

func __on_enter():
	crab.animator.play('idle')
