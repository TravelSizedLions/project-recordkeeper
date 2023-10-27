extends Node2D
class_name Shooter

@onready var player: Player = get_tree().get_first_node_in_group('player')
@onready var emitter: Node2D = $emitter
@export var __special_projectile: PackedScene

var __enabled: bool = true
var __special_enabled: bool = false
var timer = 0


func _physics_process(delta):
	if not __enabled:
		return

	__update_rotation()
	timer -= delta
	if player.is_firing() or (__special_enabled and player.holding_special()):
		if timer <= 0:
			__fire()

func __update_rotation():
	rotation = player.get_firing_direction().angle()

func __fire():
	timer = player.settings.fire_rate
	var direction: Vector2 = player.get_firing_direction()
	rotation = direction.angle()
	var speed = player.settings.projectile_speed
	
	var projectile: Projectile
	if player.is_firing():
		projectile = N.create_scene(player.settings.projectile)
		projectile.from_player()
	elif player.holding_special():
		projectile = N.create_scene(__special_projectile)
		projectile.collision_layer = CollisionLayer.Projectiles
		projectile.collision_mask = CollisionLayer.Enemies | CollisionLayer.FloatingEnemies | CollisionLayer.EnemyProjectiles
	
	projectile.set_initial_position(emitter.global_position)
	projectile.set_initial_velocity(direction, speed)

func unlock_special():
	__special_enabled = true

func enable():
	__enabled = true

func disable():
	__enabled = false
