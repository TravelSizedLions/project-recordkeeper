extends Node2D
class_name Shaker

@onready var __rng: RandomNumberGenerator = RandomNumberGenerator.new()

var __shaking: bool = true
var __intensity: float
var __timer: float


func _process(delta):
	if __shaking:
		handle_shake_frame(delta)

func shake(duration, intensity):
	__shaking = true
	__timer = duration
	__intensity = intensity

func handle_shake_frame(delta):
	__timer -= delta
	if __timer > 0:
		position = Vector2(
			__rng.randf_range(-__intensity, __intensity),
			__rng.randf_range(-__intensity, __intensity)
		)
	else:
		position = Vector2.ZERO
		__shaking = false
