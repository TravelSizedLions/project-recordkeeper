extends CharacterBody2D
class_name Player

enum Character {Jared, Ephraim}

static func retrieve():
	return TreeAccess.tree.get_first_node_in_group('player')

## Which character to start as on game start.
@export var starting_character: Character

## Jared's specific player character settings for things like movment, health, etc.
@export var jared_settings: PlayerSettings

## Ephraim's specific player character settings for things like movment, health, etc.
@export var ephraim_settings: PlayerSettings

@export_group('Invicibility Frames')
## Number of seconds the player is invincible after taking damage
@export var invincibility_time: float

## How quickly the character flickers while invincible (in cycles/second)
@export var flicker_frequency: float

@onready var fsm = $state_machine
@onready var animator = $animated_sprite_2d

var settings: PlayerSettings

var _jared_current_health: float
var _jared_max_health: float

var _ephraim_current_health: float
var _ephraim_max_health: float

var respawn_position: Vector2

var __invincible_timer: float

var __flicker_timer: float

# Health update signals
signal jared_max_health_update
signal ephraim_max_health_update

signal jared_current_health_update
signal ephraim_current_health_update

signal on_player_died

# signal for when the player switches between Jared and Ephraim
signal characters_swapped

func _ready():
	__set_up_health()
	__swap_to_jared() if starting_character == Character.Jared else __swap_to_ephraim()
	respawn_position = position

func _process(delta):
	CharUtils.update_facing(self)
	process_flicker(delta)

func _physics_process(delta):
	CharUtils.apply_gravity(self, delta)
	process_invincibility(delta)
	process_health_regen(delta)
	move_and_slide()

func process_health_regen(delta):
	if get_active_character() == Character.Jared:
		update_ephraim_current_health(_ephraim_current_health + ephraim_settings.regen_speed*delta)
	else:
		update_jared_current_health(_jared_current_health + jared_settings.regen_speed*delta)

func process_flicker(delta):
	if is_invincible():
		__flicker_timer -= delta
		if __flicker_timer < 0:
			__flicker_timer = 1/(2*flicker_frequency)
			toggle_sprite()

func process_invincibility(delta):
	if is_invincible():
		__invincible_timer -= delta
		if not is_invincible():
			show_sprite()
	
func pressed_move():
	return bool(__get_movement_axis())

func pressed_jump():
	return Input.is_action_just_pressed('jump')

func pressed_swap():
	return Input.is_action_just_pressed('swap')

func pressed_special():
	return can_use_special() && Input.is_action_just_pressed('special')

func released_special():
	return can_use_special() && Input.is_action_just_released('special')

func holding_special():
	return can_use_special() && Input.is_action_pressed('special')

func can_use_special():
	return get_active_character() == Character.Ephraim
	
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
	if not holding_special():
		__swap_to_jared() if settings == ephraim_settings else __swap_to_ephraim()
		
func is_firing():
	if __using_controller():
		var axis: Vector2 = Input.get_vector('aim_left','aim_right','aim_up','aim_down')
		return axis != Vector2.ZERO && !holding_special()
	else:
		# using mouse
		return Input.is_action_pressed('mouse_fire') && !holding_special()

func is_aiming():
	if __using_controller():
		return Input.get_vector('aim_left','aim_right','aim_up','aim_down') != Vector2.ZERO
	else:
		return true

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
		jared_hbar.connect_to_entity(self)
		update_jared_max_health(jared_settings.max_health)
		update_jared_current_health(jared_settings.max_health)

	var ephraim_hbar: EphraimHealthBar = N.find(EphraimHealthBar)
	if ephraim_hbar:
		ephraim_hbar.connect_to_entity(self)
		update_ephraim_max_health(ephraim_settings.max_health)
		update_ephraim_current_health(ephraim_settings.max_health)

func update_jared_max_health(v: float):
	_jared_max_health = v
	jared_max_health_update.emit(v)

func update_jared_current_health(v: float):
	_jared_current_health = clamp(v, 0, _jared_max_health)
	jared_current_health_update.emit(v)

func update_ephraim_max_health(v: float):
	_ephraim_max_health = v
	ephraim_max_health_update.emit(v)

func update_ephraim_current_health(v: float):
	_ephraim_current_health = clamp(v, 0, _ephraim_max_health)
	ephraim_current_health_update.emit(v)

func __swap_to_ephraim():
	__set_up_player(ephraim_settings)
	characters_swapped.emit(Character.Ephraim)

func __swap_to_jared():
	__set_up_player(jared_settings)
	characters_swapped.emit(Character.Jared)

func get_active_character() -> Character:
	return Character.Jared if settings == jared_settings else Character.Ephraim

func die():
	position = respawn_position
	velocity = Vector2.ZERO
	reset_jared_health()
	reset_ephraim_health()
	stop_invincibility()
	var area_loader: AreaLoader = get_tree().get_first_node_in_group('area_loader')
	area_loader.reload()
	on_player_died.emit()

func take_damage(amount: float):
	if is_invincible():
		return
	
	if get_active_character() == Character.Jared:
		update_jared_current_health(_jared_current_health-amount)
	else:
		update_ephraim_current_health(_ephraim_current_health-amount)

	if _jared_current_health <= 0 or _ephraim_current_health <= 0:
		die()

	start_invincibility()

func reset_jared_health():
	update_jared_current_health(_jared_max_health)

func reset_ephraim_health():
	update_ephraim_current_health(_ephraim_max_health)

func start_invincibility():
	__invincible_timer = invincibility_time
	__flicker_timer = 1/(2*flicker_frequency)
	hide_sprite()

func stop_invincibility():
	__invincible_timer = -1
	__flicker_timer = -1
	show_sprite()

func is_invincible():
	return __invincible_timer > 0

func toggle_sprite():
	animator.visible = !animator.visible

func show_sprite():
	animator.visible = true

func hide_sprite():
	animator.visible = false
