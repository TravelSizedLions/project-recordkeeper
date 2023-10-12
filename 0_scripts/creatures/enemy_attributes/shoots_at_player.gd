extends Node2D

@export var projectile: PackedScene
@export var fire_every: float = 1
@export var speed: float = 200
@export var spawn_radius: float = 25

var __timer

@onready var player: Player = Player.retrieve()

func _ready():
	__timer = fire_every
	
func _physics_process(delta):
	__timer -= delta
	if __timer < 0:
		fire()
		__timer = fire_every
		
func fire():
	var instance: Projectile = N.create_scene(projectile)
	instance.from_enemy()
	var dir: Vector2 = (player.global_position - global_position).normalized()
	instance.global_position = global_position + dir*spawn_radius
	instance.set_initial_velocity(dir, speed)
