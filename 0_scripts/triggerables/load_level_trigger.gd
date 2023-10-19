class_name LoadLevelTrigger extends Triggerable

enum LoadLevelPlayerOptions {
	LoadPlayer,
	RemovePlayer,
}

@export var level_to_load: PackedScene
@export var player_load_setting: LoadLevelPlayerOptions

func _on_trigger():
	var tree = get_tree()
	var player_layer = tree.get_first_node_in_group('player_layer')
	match player_load_setting:
		LoadLevelPlayerOptions.LoadPlayer:
			var template: PackedScene = load(DeveloperSettings.PlayerLayerResourcePath)
			N.create_scene(template, player_layer)
		LoadLevelPlayerOptions.RemovePlayer:
			for child in player_layer.get_children():
				child.queue_free()
	var area_loader: AreaLoader = get_tree().get_first_node_in_group('area_loader')
	area_loader.load_new_area(level_to_load)
