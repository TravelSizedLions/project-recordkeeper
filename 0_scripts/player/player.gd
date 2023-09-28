extends CharacterBody2D
class_name Player

@onready var animator = $animated_sprite_2d

@export_group('Movement Settings')
## How fast the player moves (in .1 pixel/second units)
@export var speed = 300.0

## Initial jump speed (in .1 pixel/second^2 units)
@export var jump_force = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(_delta):
	update_direction()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

func update_direction():
	if velocity.x > 0:
		animator.flip_h = false
	elif velocity.x < 0:
		animator.flip_h = true

func pressed_move():
	return bool(__get_movement_axis())

func pressed_jump():
	return Input.is_action_just_pressed('jump')
	
func handle_run():
	var direction = __get_movement_axis()
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
func is_moving():
	return velocity.x != 0
	
func is_falling():
	return velocity.y > 0
	
func is_rising():
	return velocity.y < 0

func __get_movement_axis():
	return Input.get_axis('left', 'right')