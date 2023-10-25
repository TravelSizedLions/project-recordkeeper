class_name SoundTrigger extends Triggerable

@export var sound: AudioStream

func _on_trigger():
	SoundManager.play_sound(sound)
