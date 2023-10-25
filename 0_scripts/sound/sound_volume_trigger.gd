class_name SoundVolumeTrigger extends Triggerable

@export_range(0, 1) var volume: float = 1

func _on_trigger():
	SoundManager.set_sound_volume(volume)
