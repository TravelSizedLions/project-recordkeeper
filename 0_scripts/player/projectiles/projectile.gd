extends RigidBody2D
class_name Projectile

@export var settings: ProjectileSettings

@onready var __timer: float = settings.max_lifetime_seconds

var __initial_position: Vector2

signal on_hit

func _enter_tree():
	contact_monitor = true
	max_contacts_reported = 100
	__initial_position = global_position
	from_player()

func _physics_process(delta):
	__timer -= delta
	if __timer < 0:
		queue_free()

func set_initial_position(global_pos: Vector2):
	global_position = global_pos
	__initial_position = global_pos

func set_initial_velocity(direction: Vector2, speed: float):
	__on_initial_velocity_set(direction, speed)

func __on_initial_velocity_set(_direction: Vector2, _speed: float):
	pass

func register_behavior(behavior: ProjectileOnHitBehavior):
	if not on_hit.is_connected(behavior.on_hit):
		on_hit.connect(behavior.on_hit, CONNECT_DEFERRED)

func on_body_entered(body):
	on_hit.emit(body)

func on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	on_hit.emit(body)

func from_player():
	collision_layer = CollisionLayer.Projectiles
	collision_mask = CollisionLayer.Default | CollisionLayer.EnemyProjectiles | CollisionLayer.Enemies | CollisionLayer.FloatingEnemies

func from_enemy():
	collision_layer = CollisionLayer.EnemyProjectiles
	collision_mask = CollisionLayer.Default | CollisionLayer.Projectiles

func get_initial_position():
	return __initial_position
