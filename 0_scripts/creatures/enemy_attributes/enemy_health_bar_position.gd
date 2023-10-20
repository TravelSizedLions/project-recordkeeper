extends Node2D
class_name EnemyHealthBarPosition

@onready var entity = get_parent()

## The entity's title
@export var title: String = ""

## The entity's maximum health
@export var max_health: float

@export var ui_element: PackedScene

signal health_update
signal max_health_update
signal entity_destroyed
signal position_updated

var __relative_position: Vector2

var _current_health: float

# FIXME: For some reason, adding elements on _ready() doesn't work...
var __init_hack: bool = false
func _physics_process(_delta):
	if not __init_hack and ui_element:
		__init_hack = true
		__relative_position = global_position - entity.global_position
		var ui = N.create_scene(ui_element)
		setup_health(ui)
		setup_name(ui)
		rename_ui(ui)
	# use a static relative position so that if the position of this node moves
	# out of place, it still looks right on screen.
	position_updated.emit(entity.global_position + __relative_position)

func rename_ui(ui):
	ui.name = "entity_ui_%s" % [ui.get_instance_id()]

func setup_health(ui: EnemyFloatingUI):
	ui.connect_to_entity(entity)
	var healthbar: EnemyHealthBar = N.get_child(ui, EnemyHealthBar)
	healthbar.connect_to_entity(entity)
	_current_health = max_health
	max_health_update.emit(max_health)
	health_update.emit(_current_health)

func setup_name(ui: EnemyFloatingUI):
	var name_label: Label = N.get_child(ui, Label)
	name_label.text = title

func take_damage(val: float):
	_current_health -= val
	health_update.emit(_current_health)
	if _current_health <= 0:
		entity.queue_free()
		entity_destroyed.emit()

func get_current_health():
	return _current_health

func get_max_health():
	return max_health
