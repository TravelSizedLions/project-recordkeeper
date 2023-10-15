extends State
class_name NightmareBlizzStarbustState

var __fire_timer: float
var __linger_timer: float
var __starburst: Node
var __locked_position: Vector2
var __rng: RandomNumberGenerator = RandomNumberGenerator.new()

@onready var __boss: NightmareBlizz = owner

@onready var __state_table = {
	move = {
		chance = .4,
		state = NightmareBlizzMoveLocationState,
		precondition = (func(): return true),
		fallback_state = NightmareBlizzMoveLocationState
	},
	follow = {
		chance = .2,
		state = NightmareBlizzFollowPlayerState,
		precondition = (func(): return true),
		fallback_state = NightmareBlizzMoveLocationState
	},
	turrets = {
		chance = .2,
		state = NightmareBlizzSpawnTurrentState,
		precondition = __boss.can_spawn_allies,
		fallback_state = NightmareBlizzMoveLocationState,
	},
	stingers = {
		chance = .2,
		state = NightmareBlizzSpawnStingerState,
		precondition = __boss.can_spawn_allies,
		fallback_state = NightmareBlizzFollowPlayerState
	}
}

func __on_physics_process(delta):
	__boss.global_position = __locked_position
	__fire_timer -= delta
	if __fire_timer < 0:
		if is_firing():
			stop_firing()
			start_linger()
		else:
			handle_linger(delta)


func __on_enter():
	var template = __boss.pick_starburst()
	__fire_timer = __boss.burst_duration_seconds
	__starburst = N.create_scene(template, __boss, __boss, "starburst")
	__locked_position = __boss.global_position


func pick_new_state():
	var luck = __rng.randf()

	for k in __state_table:
		var info = __state_table[k]
		if luck < info.chance:
			print(k, " - ", info.precondition)
			if not info.precondition.call():
				return info.fallback_state

			return info.state

		luck -= info.chance


func stop_firing():
	__starburst.queue_free()
	__starburst = null

func is_firing():
	return not __starburst == null
	
func start_linger():
	__linger_timer = __boss.linger_time

func handle_linger(physicsDelta):
	__linger_timer -= physicsDelta
	if __linger_timer < 0:
		transitioner.emit(pick_new_state())
