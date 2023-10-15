extends Node2D
class_name RotatesThingRandomly

@export var min_rotation_speed: float
@export var max_rotation_speed: float
@export var thing_to_rotate: Node2D

var __rotation_speed: float

func _ready():
	if not thing_to_rotate:
		thing_to_rotate = get_parent()
	set_rotation_variation(min_rotation_speed, max_rotation_speed)

func _physics_process(delta):
	thing_to_rotate.rotate(__rotation_speed*delta)

func set_rotation_variation(minimum, maximum):
	var rng = RandomNumberGenerator.new()
	__rotation_speed = rng.randf_range(minimum, maximum)
	__rotation_speed = deg_to_rad(__rotation_speed)

