extends CharacterBody2D
class_name Player

enum Character {Jared, Ephraim}

static func retrieve():
	return TreeAccess.tree.get_first_node_in_group('player')

## Which character to start as on game start.
@export var starting_character: Character

@export var fall_damage: float = 5

## Jared's specific player character settings for things like movment, health, etc.
@export var jared_settings: PlayerSettings

## Ephraim's specific player character settings for things like movment, health, etc.
@export var ephraim_settings: PlayerSettings

@export_group('Invicibility Frames')
## Number of seconds the player is invincible after taking damage
@export var invincibility_time: float

## How quickly the character flickers while invincible (in cycles/second)
@export var flicker_frequency: float

@onready var fsm: FSM = N.get_child(self, FSM)
@onready var animator: AnimatedSprite2D = N.get_child(self, AnimatedSprite2D)

var settings: PlayerSettings

var _jared_current_health: float
var _jared_max_health: float

var _ephraim_current_health: float
var _ephraim_max_health: float

var respawn_position: Vector2

var __invincible_timer: float

var __flicker_timer: float

var __dead: bool = false

## The last place the player was standing before a jump.
var __last_grounded_position: Vector2

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
	search_for_spawn()
	collision_layer = CollisionLayer.PlayerCharacter
	collision_mask = CollisionLayer.Default | CollisionLayer.Projectiles | CollisionLayer.Enemies
	fsm.start() 

func search_for_spawn():
	var spawn = N.find(Spawnpoint)
	if spawn:
		prints('found spawn')
		set_spawn(spawn.global_position)
	else:
		prints('did not find spawn')
		respawn_position = global_position
		__last_grounded_position = respawn_position

func set_spawn(spawn: Vector2):
	respawn_position = spawn
	__last_grounded_position = spawn
	global_position = spawn

func _process(frameDelta):
	CharUtils.update_facing(self)
	process_flicker(frameDelta)

func _physics_process(fixedDelta):
	process_invincibility(fixedDelta)
	process_health_regen(fixedDelta)
	if not __dead:
		CharUtils.apply_gravity(self, fixedDelta)
		move_and_slide()

func process_health_regen(fixedDelta):
	if get_active_character() == Character.Jared:
		update_ephraim_current_health(_ephraim_current_health + ephraim_settings.regen_speed*fixedDelta)
	else:
		update_jared_current_health(_jared_current_health + jared_settings.regen_speed*fixedDelta)

func process_flicker(frameDelta):
	if is_invincible():
		__flicker_timer -= frameDelta
		if __flicker_timer < 0:
			__flicker_timer = 1/(2*flicker_frequency)
			toggle_sprite()

func process_invincibility(fixedDelta):
	if is_invincible():
		__invincible_timer -= fixedDelta
		if not is_invincible():
			show_sprite()
	
func pressed_move():
	return bool(__get_movement_axis())

func pressed_jump():
	return Input.is_action_just_pressed('jump')

func pressed_swap():
	return Input.is_action_just_pressed('swap')

func pressed_special():
	return Input.is_action_just_pressed('special')

func released_special():
	return Input.is_action_just_released('special')

func holding_special():
	return Input.is_action_pressed('special')

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
		return axis != Vector2.ZERO
	else:
		# using mouse
		return Input.is_action_pressed('mouse_fire')

func pressed_fire():
	if __using_controller():
		return Input.is_action_just_pressed('charge_fire')
	else:
		return Input.is_action_just_pressed('mouse_fire')

func released_fire():
	if __using_controller():
		return Input.is_action_just_released('charge_fire')
	else:
		return Input.is_action_just_released('mouse_fire')

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
	N.get_child(self, ChargeLauncher).enable()
	N.get_child(self, Shooter).disable()
	characters_swapped.emit(Character.Ephraim)

func __swap_to_jared():
	__set_up_player(jared_settings)
	N.get_child(self, ChargeLauncher).disable()
	N.get_child(self, Shooter).enable()
	characters_swapped.emit(Character.Jared)

func get_active_character() -> Character:
	return Character.Jared if settings == jared_settings else Character.Ephraim

func die():
	__dead = true
	fsm.on_state_transition(DeathState)

func respawn():
	__last_grounded_position = respawn_position
	global_position = respawn_position
	velocity = Vector2.ZERO
	reset_jared_health()
	reset_ephraim_health()
	stop_invincibility()
	call_deferred('__after_respawn')

func __after_respawn():
	var area_loader: AreaLoader = get_tree().get_first_node_in_group('area_loader')
	area_loader.reload()
	on_player_died.emit()
	__dead = false

	if get_active_character() == Character.Jared:
		fsm.on_state_transition(JaredIdleState)
	else:
		fsm.on_state_transition(EphraimIdleState)

func handle_fall():
	stop_invincibility()
	var died = take_damage(fall_damage)
	if not died:
		global_position = __last_grounded_position
		velocity = Vector2.ZERO

func take_damage(amount: float):
	var died = false
	if __dead or is_invincible():
		return died
	
	if get_active_character() == Character.Jared:
		update_jared_current_health(_jared_current_health-amount)
	else:
		update_ephraim_current_health(_ephraim_current_health-amount)

	if _jared_current_health <= 0 or _ephraim_current_health <= 0:
		die()
		died = true

	start_invincibility()
	return died 

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

## Caches the last grounded position of the player if they die from falling off a cliff
func set_new_fall_spawnpoint():
	var player_capsule: CapsuleShape2D
	for c in N.get_all_children(self, CollisionShape2D):
		player_capsule = c.shape
		if player_capsule:
			break
	
	if player_capsule:
		# shifts the position to prevent accidental repeat falls
		var dir = -velocity.sign().x
		var width = player_capsule.get_rect().size.x
		__last_grounded_position = Vector2(global_position.x + dir*width, global_position.y)
