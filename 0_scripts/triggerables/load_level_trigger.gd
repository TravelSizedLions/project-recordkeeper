extends Triggerable
class_name LoadLevelTrigger

enum LoadLevelPlayerOptions {
	LoadPlayer,
	RemovePlayer,
}

const PlayerLayerResourcePath = "res://game_objects/player/player_layer.tscn"

@export_file var level_to_load: String
@export var player_load_setting: LoadLevelPlayerOptions
@export var delay: float = 0

func _on_trigger():
	if delay > 0:
		TreeAccess.tree.create_timer(delay).timeout.connect(__load_level)
	else:
		__load_level()
	
func __load_level():
	var area_loader: AreaLoader = TreeAccess.tree.get_first_node_in_group('area_loader')
	area_loader.on_finished_load.connect(__try_load_player)
	area_loader.load_new_area(level_to_load)

func __try_load_player():
	var player_layer = TreeAccess.tree.get_first_node_in_group('player_layer')
	match player_load_setting:
		LoadLevelPlayerOptions.LoadPlayer:
			var template: PackedScene = load(PlayerLayerResourcePath)
			N.create_scene(template, player_layer)
			var player: Player = Player.retrieve()
			player.search_for_spawn()
		LoadLevelPlayerOptions.RemovePlayer:
			for child in player_layer.get_children():

				child.queue_free()
	
	var area_loader: AreaLoader = TreeAccess.tree.get_first_node_in_group('area_loader')
	area_loader.on_finished_load.disconnect(__try_load_player)

