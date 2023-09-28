extends CharacterBody2D
class_name Player

@export_group('Movement Settings')
## How fast the player moves (in .1 pixel/second units)
@export var speed = 300.0

## Initial jump speed (in .1 pixel/second^2 units)
@export var jump_force = -400.0

@export_group('Components')
## The player's animated sprite component.
@export var animator: AnimatedSprite2D = null

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

func update_direction():
	if velocity.x > 0:
		animator.flip_h = false
	elif velocity.x < 0:
		animator.flip_h = true
