extends Node2D
class_name ChargeLauncher

@onready var charger: Charger = Charger.new()
@onready var player: Player = Player.retrieve()
@onready var arcdrawer: ArcDrawer = N.get_child(self, ArcDrawer)

@export_group('Launcher Settings')
## The hardest the player can throw the thing
@export var max_lob_force: float = 500

@export var charge_time: float = 0.66

## How far away the projectile starts from the player
@export var buffer_radius: float = 50

## What to launch
@export var projectile: PackedScene

@export var _last_known_direction: Vector2

func _ready():
	charger.set_max_charge_time(charge_time)

func _physics_process(delta):
	if player.pressed_special():
		charger.start_charge(delta)
	elif player.released_special():
		fire()
		charger.reset_charge()

	charger.handle_charge(delta)

	if charger.is_charging():
		if player.is_aiming():
			_last_known_direction = player.get_firing_direction()

		arcdrawer.predict_arc(
			global_position + _last_known_direction*buffer_radius, 
			_last_known_direction*max_lob_force*charger.percent_charged()
		)

func fire():
	var p = N.create_scene(projectile)
	var force = max_lob_force*charger.percent_charged()
	p.position = global_position + _last_known_direction*buffer_radius
	p.set_initial_velocity(_last_known_direction, force)
	arcdrawer.clear_arc()
