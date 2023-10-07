extends EnemyAttribute
class_name CanFloatAway

@onready var enemy: Enemy = owner
@export var floating_away: bool = false

@onready var rotation_speed: float = RandomNumberGenerator.new().randf()*10+5
@onready var rotation_dir: float = RandomNumberGenerator.new().randf()*2-1

func _physics_process(delta):
	if floating_away:
		enemy.velocity.y = -1200*delta
		if rotation_dir < 0:
			enemy.rotation_degrees -= rotation_speed*delta
		else:
			enemy.rotation_degrees += rotation_speed*delta
	enemy.move_and_slide()

func apply_attribute():
	floating_away = true
	enemy.disable()
