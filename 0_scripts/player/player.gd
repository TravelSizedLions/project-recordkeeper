extends CharacterBody2D
class_name Player

enum Character {Jared, Ephraim}

@onready var animator = $animated_sprite_2d

@export var starting_character: Character

@export var jared_settings: PlayerSettings

@export var ephraim_settings: PlayerSettings

@onready var fsm = $state_machine

var settings: PlayerSettings

var _jared_current_health: float
var _jared_max_health: float

var _ephraim_current_health: float
var _ephraim_max_health: float

# Health update signals
signal jared_max_health_update
signal ephraim_max_health_update

signal jared_current_health_update
signal ephraim_current_health_update

# signal for when the player switches between Jared and Ephraim
signal characters_swapped

func _ready():
	__set_up_health()
	__swap_to_jared() if starting_character == Character.Jared else __swap_to_ephraim()

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
	__swap_to_jared() if settings == ephraim_settings else __swap_to_ephraim()
		
func is_firing():
	if __using_controller():
		var axis: Vector2 = Input.get_vector('aim_left','aim_right','aim_up','aim_down')
		return axis != Vector2.ZERO
	else:
		# using mouse
		return Input.is_action_pressed('mouse_fire')

func get_firing_direction():
	if __using_controller():
		return Input.get_vector('aim_left','aim_right','aim_up','aim_down').normalized()
	else:
		return (get_tree().current_scene.get_global_mouse_position() - global_position).normalized()

func __using_controller():
	return Input.get_connected_joypads().size() > 0

func __get_movement_axis():
	return Input.get_axis('left', 'right')

func __set_up_player(next_settings: PlayerSettings):
	settings = next_settings
	animator.sprite_frames = settings.sprites
	fsm.on_state_transition(settings.start_state)

func __set_up_health():
	print('setting up health')
	var jared_hbar: JaredHealthBar = N.find(JaredHealthBar)
	if jared_hbar:
		jared_hbar.connect_to_player(self)
		update_jared_max_health(jared_settings.max_health)
		update_jared_current_health(jared_settings.max_health)

	var ephraim_hbar: EphraimHealthBar = N.find(EphraimHealthBar)
	if ephraim_hbar:
		ephraim_hbar.connect_to_player(self)
		update_ephraim_max_health(ephraim_settings.max_health)
		update_ephraim_current_health(ephraim_settings.max_health)

func update_jared_max_health(v: float):
	_jared_max_health = v
	jared_max_health_update.emit(v)

func update_jared_current_health(v: float):
	_jared_current_health = v
	jared_current_health_update.emit(v)

func update_ephraim_max_health(v: float):
	_ephraim_max_health = v
	ephraim_max_health_update.emit(v)

func update_ephraim_current_health(v: float):
	_ephraim_current_health = v
	ephraim_current_health_update.emit(v)

func __swap_to_ephraim():
	__set_up_player(ephraim_settings)
	characters_swapped.emit(Character.Ephraim)

func __swap_to_jared():
	__set_up_player(jared_settings)
	characters_swapped.emit(Character.Jared)

func get_active_character() -> Character:
	return Character.Jared if settings == jared_settings else Character.Ephraim
