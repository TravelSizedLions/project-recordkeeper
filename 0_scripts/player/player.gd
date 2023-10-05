extends CharacterBody2D
class_name Player

enum Character {Jared, Ephraim}

@onready var animator = $animated_sprite_2d

@export var starting_character: Character

@export var jared_settings: PlayerSettings

@export var ephraim_settings: PlayerSettings

@onready var fsm = $state_machine

var settings

func _ready():
	__set_up_player(jared_settings)

func _process(_delta):
	CharUtils.update_facing(self)

func _physics_process(delta):
	CharUtils.apply_gravity(self, delta)
	move_and_slide()

func pressed_move():
	return bool(__get_movement_axis())

func pressed_jump():
	return Input.is_action_just_pressed('jump')

func pressed_swap():
	return Input.is_action_just_pressed('swap')
	
func handle_run():
	var direction = __get_movement_axis()
	if direction:
		velocity.x = direction * settings.speed
	else:
		velocity.x = move_toward(velocity.x, 0, settings.speed)
	
func is_moving():
	return velocity.x != 0
	
func is_falling():
	return velocity.y > 0
	
func is_rising():
	return velocity.y < 0

func swap_player(): 
	if settings == jared_settings:
		__set_up_player(ephraim_settings)
	else:
		__set_up_player(jared_settings)

func is_firing():
	if __using_controller():
		var axis: Vector2 = Input.get_vector('aim_left','aim_right','aim_up','aim_down')
		return axis != Vector2.ZERO
	else:
		# using mouse
		return Input.is_action_pressed('mouse_fire')

func get_firing_direction():
	var direction: Vector2
	if __using_controller():
		direction = Input.get_vector('aim_left','aim_right','aim_up','aim_down')
	else:
		direction = get_viewport().get_mouse_position() - position
	return direction.normalized()
	
func __using_controller():
	return Input.get_connected_joypads().is_empty()

func __get_movement_axis():
	return Input.get_axis('left', 'right')

func __set_up_player(next_settings: PlayerSettings):
	settings = next_settings
	animator.sprite_frames = settings.sprites
	fsm.on_state_transition(settings.start_state)
