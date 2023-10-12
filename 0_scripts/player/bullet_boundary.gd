extends Area2D
class_name BulletBoundary

func on_body_exited(body):
	var projectile = N.get_child(body, Projectile)
	if projectile:
		projectile.queue_free()

func on_body_entered(body):
	var projectile: Projectile = N.get_child(body, Projectile)
	if projectile:
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
		
		
