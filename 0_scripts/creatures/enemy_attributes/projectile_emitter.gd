extends Node2D
class_name ProjectileEmitter

## Shoots every N seconds
@export var frequency: float = 1

## Shoots at this speed (in 0.1 pixels/second)
@export var speed: float = 200

## how far away to spawn the projectile from the enemey
@export var spawn_radius: float = 25

## The projectile to fire
@export var projectile: PackedScene

@onready var __timer: float = frequency

func _physics_process(delta):
	__timer -= delta
	if __timer < 0:
		fire()
		
func fire():
	__timer = frequency
	var instance: Projectile = N.create_scene(projectile)
	instance.from_enemy()
	var dir = Vector2.RIGHT.rotated(global_rotation)
	instance.set_initial_position(global_position + dir*spawn_radius)
	instance.set_initial_velocity(dir, speed)
