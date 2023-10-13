extends Node2D
class_name RotatesRandomly

@onready var enemy: Enemy = owner

@export var min_rotation_speed: float
@export var max_rotation_speed: float

var __rotation_speed: float

func _ready():
	var rng = RandomNumberGenerator.new()
	__rotation_speed = rng.randf_range(min_rotation_speed, max_rotation_speed)
	__rotation_speed = deg_to_rad(__rotation_speed)

func _physics_process(delta):
	enemy.rotate(__rotation_speed*delta)

