extends CharacterBody2D
class_name Player

@export var speed = 300.0
@export var jump_force = -400.0
@export var animator: AnimatedSprite2D = null
@export var body: CharacterBody2D = null

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
