extends Triggerable
class_name MusicTrigger

@export var __start_automatically: bool = true

@export var __music: AudioStream

func _ready():
	if __start_automatically and __music:
		SoundManager.play_music(__music)

func _on_trigger():
	if __music:
		SoundManager.play_music(__music)
