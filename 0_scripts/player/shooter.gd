extends Node2D
class_name Shooter

@onready var player: Player = get_tree().get_first_node_in_group('player')
@onready var emitter: Node2D = $emitter

var __enabled: bool = true
var timer = 0

func _physics_process(delta):
	if not __enabled:
		return

	__update_rotation()
	timer -= delta
	if player.is_firing():
		if timer <= 0:
			__fire()

func __update_rotation():
	rotation = player.get_firing_direction().angle()

func __fire():
	timer = player.settings.fire_rate
	var direction: Vector2 = player.get_firing_direction()
	rotation = direction.angle()

	var speed = player.settings.projectile_speed
	var projectile: Projectile = N.create_scene(player.settings.projectile)
	projectile.from_player()
	projectile.set_initial_position(emitter.global_position)
	projectile.set_initial_velocity(direction, speed)

func enable():
	__enabled = true

func disable():
	__enabled = false