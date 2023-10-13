extends Node2D
class_name EnemyHealthBarPosition

@onready var enemy: Enemy = owner

## The enemy's title
@export var title: String = ""

## The enemy's maximum health
@export var max_health: float

signal health_update
signal max_health_update
signal enemy_destroyed
signal position_updated

var _current_health: float

func _ready():
	var ui = N.get_child(self, EnemyFloatingUI)
	setup_health(ui)
	setup_name(ui)
	detach_ui(ui)

func _physics_process(_delta):
	position_updated.emit(global_position)

func detach_ui(ui):
	ui.name = "enemy_ui_%s" % [ui.get_instance_id()]
	ui.get_parent().remove_child(ui)
	get_tree().root.add_child(ui)
	for child in get_tree().root.get_children():
		print('child is ', child.name)

func setup_health(ui: EnemyFloatingUI):
	ui.connect_to_entity(enemy)
	var healthbar: EnemyHealthBar = N.get_child(ui, EnemyHealthBar)
	healthbar.connect_to_entity(enemy)
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
		enemy.queue_free()
		enemy_destroyed.emit()
