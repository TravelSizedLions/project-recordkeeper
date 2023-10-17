extends Triggerable
class_name StopMusicTrigger

func _on_trigger():
	SoundManager.stop_music(1)

