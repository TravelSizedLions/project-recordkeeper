extends Node2D
class_name ChargeLauncher

@onready var charger: Charger = Charger.new()
@onready var player: Player = Player.retrieve()
@onready var arcdrawer: ArcDrawer = N.get_child(self, ArcDrawer)

@export_group('Launcher Settings')
## The hardest the player can throw the thing
@export var max_lob_force: float = 500

## the angle to lob the projectile at in degrees
@export var lob_angle: float = -33

## How far away the projectile starts from the player
@export var buffer_radius: float = 50

## What to launch
@export var projectile: PackedScene

func _physics_process(delta):
	if player.pressed_special():
		charger.start_charge(delta)
	elif player.released_special():
		fire()
		charger.reset_charge()

	charger.handle_charge(delta)

	if charger.is_charging():
		var dir = player.get_firing_direction()
		arcdrawer.predict_arc(
			global_position + dir*buffer_radius, 
			dir*max_lob_force*charger.percent_charged()
		)

func fire():
	var p = N.create_scene(projectile)
	var dir = player.get_firing_direction()
	var force = max_lob_force*charger.percent_charged()
	p.position = global_position + dir*buffer_radius
	p.set_initial_velocity(dir, force)
	arcdrawer.clear_arc()
