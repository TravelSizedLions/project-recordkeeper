extends State
class_name NightmareBlizzMoveLocationState


@onready var __boss: NightmareBlizz = owner
var __end_location: Vector2
var __start_location: Vector2
var __timer: float = 0

func __on_physics_process(delta):
	__timer = clamp(__timer + delta, 0, __boss.move_time_seconds)
	if __timer >= __boss.move_time_seconds:
		__boss.global_position = __end_location
		transitioner.emit(NightmareBlizzStarbustState)
	else:
		var t = ease(__timer/__boss.move_time_seconds, __boss.move_easing)
		__boss.global_position = (1-t)*__start_location + t*__end_location

func __on_enter():
	__timer = 0
	__start_location = __boss.global_position
	__end_location = __boss.pick_location()

