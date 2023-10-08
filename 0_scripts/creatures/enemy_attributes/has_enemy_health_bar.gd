extends Node
class_name HasEnemyHealthBar

@onready var enemy: Enemy = owner

## The enemy's title
@export var title: String = ""

## The enemy's maximum health
@export var max_health: float

signal health_update
signal max_health_update

var _current_health: float

func _ready():
	setup_health()
	setup_name()

func setup_health():
	var healthbar: EnemyHealthBar = N.get_child(enemy, EnemyHealthBar)
	healthbar.connect_to_entity(enemy)
	_current_health = max_health
	max_health_update.emit(max_health)
	health_update.emit(_current_health)

func setup_name():
	var name_label: Label = N.get_child(self, Label)
	name_label.text = title

func take_damage(val: float):
	_current_health -= val
	health_update.emit(_current_health)
	if _current_health <= 0:
		enemy.queue_free()
