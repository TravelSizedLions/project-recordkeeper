extends Enemy
class_name NightmareBlizz

@export_group('Movement Settings')
## How long it takes Blizz to move from one location to the next, in seconds
@export var move_time_seconds: float = 1

## How much to ease into moving between locations. See https://ask.godotengine.org/59172/how-do-i-properly-use-the-ease-function
@export_range(-5, 5) var move_easing = -3

## How longer for blizz to linger in one state before moving to the next
@export var linger_time: float = 2

## Hard Acceleration - How quickly to accelerate when following the player (in .1 pix/sec^2 units).
@export var follow_hard_acceleration: float = 1200

## Soft Acceleration How quickly to accelerate when following the player (in .1 pix/sec^2 units).
@export var follow_soft_acceleration: float = 400

## How quickly to decelerate when arriving at the player's location (in .1 pix/sec^2 units)
@export var follow_deceleration: float = 1200

## How fast blizz is allowed to move when following the player (in .1 pix/sec units)
@export var max_follow_speed: float = 8000

## How close Blizz is allowed to get to the player during follow
@export var __min_follow_distance: float = 250


@export_group("Attack Settings")

## The number of stingers to spawn per phase
@export var __num_stingers_to_spawn: int = 2

## The scene template for following and shooting at the player.
@export var __shooter_templates: Array

## A list of packed scenes for types of startburst firing patterns
@export var __burst_patterns: Array

## How long to fire star busts for
@export var burst_duration_seconds: float = 2

## How long to follow the player for during follow fire
@export var follow_duration_seconds: float = 10


@export_group('Node References')
## Parent node for where blizz can move
@export var __targets: Node2D

## Parent node for where turrets can spawn
@export var __turret_targets: Node2D

## The area where stingers can spawn
@export var __stinger_spawn_area: CircleGizmo

@export_group('Scene Templates')
## The scene template for the turret
@export var __turret_template: PackedScene

## The scene template for the stinger
@export var __stinger_template: PackedScene


@onready var __player: Player = Player.retrieve()
@onready var __rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var __body: CharacterBody2D = N.get_child(self, CharacterBody2D)
var __last_location: Node2D

var __turrets: Array = []
var __stingers: Array = []

func _ready():
	N.get_child(self, FSM).start()

func _exit_tree():
	for turret in __turrets:
		turret.queue_free()
	
	for stinger in __stingers:
		stinger.queue_free()

func pick_starburst() -> PackedScene:
	if __burst_patterns.size() == 0:
		return null

	return __burst_patterns[__rng.randi_range(0, __burst_patterns.size()-1)]

func pick_shooter():
	if __shooter_templates.size() == 0:
		return null

	return __shooter_templates[__rng.randi_range(0, __shooter_templates.size()-1)]

func pick_location() -> Vector2:
	var locations = __targets.get_children()
	if locations.size() == 0:
		return Vector2.ZERO

	var index = __rng.randi_range(0, locations.size() - 1)
	if locations[index] == __last_location:
		index = index + 1 % locations.size()

	return locations[index].global_position

func should_follow_player():
	if not _enabled:
		return false

	if global_position.y > __player.global_position.y:
		return true
	
	var dist: float = (global_position - __player.global_position).length()
	return dist > __min_follow_distance

func accelerate_towards_player(physicsDelta: float):
	var dir = global_position.direction_to(__player.global_position).normalized()

	var v = __body.velocity
	if abs(dir.x) < abs(dir.y):
		v = v + Vector2(dir.x*follow_soft_acceleration, dir.y*follow_hard_acceleration)*physicsDelta
	else:
		v = v + Vector2(dir.x*follow_hard_acceleration, dir.y*follow_soft_acceleration)*physicsDelta
	
	__body.velocity = v

	if __body.velocity.length() > max_follow_speed:
		__body.velocity = __body.velocity.normalized()*max_follow_speed
	
	__body.move_and_slide()

func decelerate(physicsDelta):
	var speed = __body.velocity.length()
	speed = clamp(speed - follow_deceleration*physicsDelta, 0, max_follow_speed)
	__body.velocity = __body.velocity.normalized()*speed
	__body.move_and_slide()

func spawn_turrets():
	for loc in __turret_targets.get_children():
		var turret: Enemy = N.create_scene(__turret_template, loc)
		turret.destroyed.connect(on_turret_destroyed)
		__turrets.append(turret)

func can_spawn_allies():
	var has_no_allies = __turrets.size() == 0 && __stingers.size() == 0
	var health_info: EnemyHealthBarPosition = N.get_child(self, EnemyHealthBarPosition)
	
	if health_info:
		var health_percent = health_info.get_current_health()/health_info.get_max_health()
		return has_no_allies && health_percent < .5
	
	return has_no_allies

func spawn_stingers():
	for i in range(__num_stingers_to_spawn):
		var dist = __rng.randf()*__stinger_spawn_area.radius
		var angle = deg_to_rad(__rng.randf()*360)
		var relative_position = Vector2.RIGHT.rotated(angle)*dist
		var stinger: Enemy = N.create_scene(__stinger_template)
		stinger.global_position = global_position + relative_position
		stinger.destroyed.connect(on_stinger_destroyed)
		__stingers.append(stinger)

func on_turret_destroyed(entity):
	var index = __turrets.find(entity)
	if index >= 0:
		__turrets.remove_at(index)

func on_stinger_destroyed(entity):
	var index = __stingers.find(entity)
	if index >= 0:
		__stingers.remove_at(index)

