extends CharacterBody2D

@export var speed = 300.0
@export var jump_force = -400.0
@export var animator: AnimatedSprite2D = null

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: float = 0
var has_jumped: bool = false
var animation_locked: bool = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	elif has_jumped:
		land()

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction*speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_direction()
	update_animation()
	
func jump():
	velocity.y = jump_force
	animator.play('rising')
	has_jumped = true
	animation_locked = true
	
func land():
	animator.play('land')
	has_jumped = false
	animation_locked = true


func update_animation():
	if animation_locked: return
	if direction != 0:
		animator.play('run')
	else:
		animator.play('idle')

func update_direction():
	if direction > 0:
		animator.flip_h = false
	elif direction < 0:
		animator.flip_h = true
	
func on_animation_finished():
	if animator.animation == 'land':
		animation_locked = false
