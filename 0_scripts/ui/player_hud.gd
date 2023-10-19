extends CanvasLayer
class_name PlayerHUD

@export var active_character_slot: Control
@export var inactive_character_slot: Control

@export var jared_info: Control
@export var ephraim_info: Control

func _enter_tree():
	var player = Player.retrieve()
	player.characters_swapped.connect(__on_characters_swapped)
	__on_characters_swapped(player.get_active_character())

func __on_characters_swapped(to_character: Player.Character):
	jared_info.get_parent().remove_child(jared_info)
	ephraim_info.get_parent().remove_child(ephraim_info)

	if to_character == Player.Character.Jared:
		active_character_slot.add_child(jared_info)
		inactive_character_slot.add_child(ephraim_info)
	else:
		active_character_slot.add_child(ephraim_info)
		inactive_character_slot.add_child(jared_info)

