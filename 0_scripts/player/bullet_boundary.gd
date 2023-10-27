extends Area2D
class_name BulletBoundary

@export var buffer: float = 50

@onready var cam: Camera2D = N.find(Camera2D)
var col: CollisionShape2D
var shape: RectangleShape2D

func _enter_tree():
	get_tree().root.propagate_call('find_projectile_boundary')

func _ready():
	col = N.get_child(self, CollisionShape2D)
	shape = col.shape
	watch_viewport()
	
func _physics_process(_delta):
	col.global_position = cam.get_screen_center_position()

func watch_viewport():
	var size = get_viewport_rect().size
	shape.size = Vector2(size.y, size.x) + Vector2(2*buffer, 2*buffer)
	col.global_position = cam.get_screen_center_position()

func on_body_exited(body):
	var projectile = N.get_child(body, Projectile)
	if projectile and not is_frozen_bullet(projectile):
		projectile.queue_free()

func on_body_entered(body):
	var projectile: Projectile = N.get_child(body, Projectile)
	if projectile and not is_frozen_bullet(projectile):
		var initial_position = projectile.get_initial_position()
		if started_outside(initial_position):
			projectile.queue_free()

func started_outside(initial_position: Vector2):
	var state = get_world_2d().direct_space_state
	var args = PhysicsPointQueryParameters2D.new()
	args.position = initial_position
	args.collide_with_bodies = false
	args.collide_with_areas = true
	args.collision_mask = CollisionLayer.Auxiliary
	var results = state.intersect_point(args)
	
	for result in results:
		if result.collider == self:
			return false
	
	return true
		
func is_frozen_bullet(projectile: Projectile):
	var freeze_attr: FreezeOnHitBehavior = N.get_child(projectile, FreezeOnHitBehavior)
	return freeze_attr and freeze_attr.is_applied()
