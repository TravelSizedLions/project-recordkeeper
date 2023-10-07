class_name CharUtils
# Get the gravity from the project settings to be synced with RigidBody nodes.
static var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

static func apply_gravity(body: CharacterBody2D, delta: float):
	if not body.is_on_floor():
		body.velocity.y += gravity * delta

static func update_facing(body):
	var animator = N.get_child(body, AnimatedSprite2D)
	if not animator:
		push_warning('no animator found in CharacterBody "%s"' % [body])
		return

	if body is CharacterBody2D:
		if body.velocity.x > 0:
			animator.flip_h = false
		elif body.velocity.x < 0:
			animator.flip_h = true
	elif body is RigidBody2D:
		if body.linear_velocity.x > 0:
			animator.flip_h = false
		elif body.linear_velocity.x < 0:
			animator.flip_h = true
