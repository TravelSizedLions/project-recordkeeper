extends RigidBody2D
class_name Projectile

@export var settings: ProjectileSettings

@onready var __timer: float = settings.max_lifetime_seconds

signal on_hit

func _enter_tree():
	contact_monitor = true
	max_contacts_reported = 100

func _physics_process(delta):
	__timer -= delta
	if __timer < 0:
		queue_free()

func set_initial_velocity(_direction: Vector2, _speed: float):
	pass

func register_behavior(behavior: ProjectileOnHitBehavior):
	print('registering ', behavior)
	if not on_hit.is_connected(behavior.on_hit):
		on_hit.connect(behavior.on_hit, CONNECT_DEFERRED)

func on_body_entered(body):
	print('body_entered')
	on_hit.emit(body)

func on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	print('body_shape_entered')
	on_hit.emit(body)
