extends State
class_name NightmareBlizzSpawnTurrentState

@onready var __boss: NightmareBlizz = owner

var __timer: float
var __has_spawned: bool


func __on_physics_process(delta):
	__timer -= delta
	if __timer < 0:
		if __has_spawned:
			transitioner.emit(NightmareBlizzMoveLocationState)
		else:
			__boss.spawn_turrets()
			__has_spawned = true			
			__timer = 0.5

func __on_enter():
	__timer = 0.5
	__has_spawned = false
