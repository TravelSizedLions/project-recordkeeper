extends Node2D
class_name ProjectileEmitter

## Shoots every N seconds
@export var frequency: float = 1

## Offsets frequency by a certain amount in seconds
@export var offset: float = 0

## Shoots at this speed (in 0.1 pixels/second)
@export var speed: float = 200

## how far away to spawn the projectile from the enemey
@export var spawn_radius: float = 25

## The projectile to fire
@export var projectile: PackedScene

@warning_ignore("unused_private_class_variable")
@onready var __bounds: BulletBoundary = get_tree().get_first_node_in_group('bullet_boundary')

func _ready():
	get_tree().create_timer(frequency-offset).timeout.connect(fire)
	
func fire():
	var dir = Vector2.RIGHT.rotated(global_rotation)
	var pos = global_position + dir*spawn_radius
	if not __bounds.started_outside(pos):
		var instance: Projectile = N.create_scene(projectile)
		instance.from_enemy()
		instance.set_initial_position(pos)
		instance.set_initial_velocity(dir, speed)

	set_timer()

func set_timer():
	get_tree().create_timer(frequency).timeout.connect(fire)
