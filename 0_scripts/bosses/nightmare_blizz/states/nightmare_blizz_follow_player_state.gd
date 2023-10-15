extends State
class_name NightmareBlizzFollowPlayerState

@onready var __boss: NightmareBlizz = owner
var __timer: float
var __shooter: Node

func __on_physics_process(delta):
	__timer -= delta
	if __timer > 0:
		if __boss.should_follow_player():
			__boss.accelerate_towards_player(delta)
		else:
			__boss.decelerate(delta)
	else:
		transitioner.emit(NightmareBlizzMoveLocationState)

func __on_enter():
	__timer = __boss.follow_duration_seconds
	__shooter = N.create_scene(__boss.pick_shooter(), __boss)

func __on_exit():
	__boss.velocity = Vector2.ZERO
	__shooter.queue_free()
	__shooter = null