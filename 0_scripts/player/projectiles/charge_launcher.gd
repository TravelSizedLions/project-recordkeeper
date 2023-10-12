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

## The maximum number of launchables this launcher can carry
@export var max_amount: int = 5

var __remaining_amount: int

## What to launch
@export var projectile: PackedScene

var _last_known_direction: Vector2

signal on_update_capacity

func _ready():
	__connect_to_ui()
	__reset_to_max()
	charger.set_max_charge_time(charge_time)
	player.on_player_died.connect(__reset_to_max)

func _physics_process(delta):
	if __remaining_amount > 0 && player.pressed_special():
		charger.start_charge(delta)
	elif charger.is_charging() && player.released_special():
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
	__remaining_amount -= 1
	on_update_capacity.emit(__remaining_amount, max_amount)

func __connect_to_ui():
	var ammo_tracker: AmmoTracker = N.find(AmmoTracker)
	if ammo_tracker:
		ammo_tracker.connect_to_entity(self)

func __reset_to_max():
	__remaining_amount = max_amount
	on_update_capacity.emit(__remaining_amount, max_amount)

