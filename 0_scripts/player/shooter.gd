extends Node2D

@onready var player: Player = get_tree().get_first_node_in_group('player')

var timer = 0

func _physics_process(delta):
	timer -= delta
	if player.is_firing():
		if timer <= 0:
			__fire()
	

func __fire():
	timer = player.settings.fire_rate
	var direction: Vector2 = player.get_firing_direction()
	var speed = player.settings.projectile_speed
	var projectile: Projectile = player.settings.projectile.instantiate()
	projectile.set_initial_velocity(direction, speed)

		
