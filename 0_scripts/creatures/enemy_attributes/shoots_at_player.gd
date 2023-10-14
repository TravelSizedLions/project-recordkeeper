extends Node2D
class_name ShootsAtPlayer

@export var projectile: PackedScene
@export var fire_every: float = 1
@export var speed: float = 200
@export var spawn_radius: float = 25

var _enabled: bool = true
var __timer: float

@onready var player: Player = Player.retrieve()

func _ready():
	__timer = fire_every
	
func _physics_process(delta):
	if _enabled:
		__timer -= delta
		if __timer < 0:
			fire()
			__timer = fire_every
		
func fire():
	var instance: Projectile = N.create_scene(projectile)
	instance.from_enemy()
	var dir: Vector2 = (player.global_position - global_position).normalized()
	instance.set_initial_position(global_position + dir*spawn_radius)
	instance.set_initial_velocity(dir, speed)

func enable():
	_enabled = true
	__timer = fire_every

func disable():
	_enabled = false
	__timer = -1
