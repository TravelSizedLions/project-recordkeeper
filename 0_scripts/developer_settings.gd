@tool
class_name DeveloperSettings extends EditorScript

const PlayerLayerSettingPath = "travel_sized_lions/player/player_settings/player_layer"
const PlayerLayerResourcePath = "res://game_objects/player/player_layer.tscn"

func _run() -> void:
	__register_setting(PlayerLayerSettingPath, PlayerLayerResourcePath, TYPE_STRING, "The player prefab to spawn and remove from levels.")
	
	var error = ProjectSettings.save()
	if error:
		push_error("Error on creating custom project settings: %d" % error)

func __register_setting(name: String, default_value, type, hint_string: String = "", hint: int = PROPERTY_HINT_NONE):
	if ProjectSettings.has_setting(name):
		return

	var setting_info = {
		name = name,
		type = type,
		hint = hint,
		hint_string = hint_string
	}
	
	ProjectSettings.set_setting(name, default_value)
	ProjectSettings.add_property_info(setting_info)
	ProjectSettings.set_initial_value(name, default_value)
