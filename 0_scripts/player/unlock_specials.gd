class_name UnlockSpecials extends Triggerable

func _on_trigger():
	var ui: CanvasItem = TreeAccess.tree.get_first_node_in_group('ammo_tracker')
	var player = Player.retrieve()
	var launcher: ChargeLauncher = N.get_child(player, ChargeLauncher)
	launcher.reload_special_ammo()
	var shooter: Shooter = N.get_child(player, Shooter)
	shooter.unlock_special()
	ui.visible = true
	
