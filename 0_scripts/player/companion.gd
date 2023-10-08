extends AnimatedSprite2D
class_name Companion

@export var settings: CompanionSettings
@onready var player = get_tree().get_first_node_in_group('player')

func _physics_process(_delta):
	var player_pos = player.global_position
	var comp_pos = global_position
	var dist = abs(comp_pos.x - player_pos.x)

	# always interp to player height, but don't interp right on top of them.
	global_position.y = comp_pos.y*(1-settings.band_strength) + player_pos.y*settings.band_strength
	if dist > settings.tail_distance:
		global_position.x = comp_pos.x*(1-settings.band_strength) + player_pos.x*settings.band_strength
