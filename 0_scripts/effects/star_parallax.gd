extends Node2D
class_name StarParallax

@export var __template: PackedScene
@export var __num_stars: int = 100
@export var __min_size: float = 0.002
@export var __max_size: float = 1
@export var __min_speed: float
@export var __max_speed: float
@onready var __rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	generate_initial()

func generate_initial():
	var viewport = get_viewport()
	var cam = viewport.get_camera_2d()
	for i in range(__num_stars):
		var instance = N.create_scene(__template, self)
		instance.global_position = get_random_screen_position(viewport, cam)
		var body = N.get_child(instance, CharacterBody2D)
		body.velocity = Vector2(__rng.randf_range(-__max_speed, -__min_speed), 0)
		var scale = __rng.randf_range(__min_size, __max_size)
		instance.global_scale = Vector2(scale, scale)
		
		var screen_notifier: VisibleOnScreenNotifier2D = N.get_child(instance, VisibleOnScreenNotifier2D)
		if screen_notifier:
			screen_notifier.screen_exited.connect(create_instance_resetter(instance))

func get_random_screen_position(viewport: Viewport, camera: Camera2D) -> Vector2:
	var cam_pos: Vector2
	if not camera:
		cam_pos = Vector2.ZERO
	else:
		cam_pos = camera.global_position

	var bounds = viewport.get_visible_rect().size
	var relative_position: Vector2 = Vector2(
		__rng.randf_range(-bounds.x, bounds.x),
		__rng.randf_range(-bounds.y, bounds.y)
	)
	
	return cam_pos + Vector2.RIGHT*bounds + relative_position

func create_instance_resetter(instance):
	return func():
		var viewport = get_viewport()
		var cam = viewport.get_camera_2d()
		instance.global_position = get_random_screen_position(viewport, cam)
		instance.global_position.x += viewport.get_visible_rect().size.x
		var body = N.get_child(instance, CharacterBody2D)
		body.velocity = Vector2(__rng.randf_range(-__max_speed, -__min_speed), 0)
		var scale = __rng.randf_range(__min_size, __max_size)
		instance.global_scale = Vector2(scale, scale)
		
