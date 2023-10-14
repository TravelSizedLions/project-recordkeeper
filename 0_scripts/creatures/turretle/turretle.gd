extends Enemy
class_name Turretle


@export var override_defaults: bool

@export var frequency: float = 1
@export var speed: float = 200
@export var offset: float = 0

func _ready():
	if override_defaults:
		var emitter: ProjectileEmitter = N.get_child(self, ProjectileEmitter)
		emitter.speed = speed
		emitter.frequency = frequency
		offset = fmod(offset, frequency)
		emitter.set_timer(frequency-offset)
	
