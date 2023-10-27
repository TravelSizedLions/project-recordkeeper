class_name UnlockEphraimWeaponTrigger extends Triggerable


func _on_trigger():
	prints('triggering!')
	var ui: CanvasItem = TreeAccess.tree.get_first_node_in_group('ammo_tracker')
	var player = Player.retrieve()
	var launcher: ChargeLauncher = N.get_child(player, ChargeLauncher)
	launcher.reload_special_ammo()
	ui.visible = true
	
