extends Triggerable
class_name MusicTrigger

@export var __start_automatically: bool = true

@export var __music: AudioStream
@export var __cross_fade: float = 0
@export var __volume: float = 1

func _ready():
	if __start_automatically and __music:
		SoundManager.set_music_volume(__volume)
		SoundManager.play_music_at_volume(__music, __volume, __cross_fade)

func _on_trigger() :
	if __music:
		SoundManager.set_music_volume(__volume)
		SoundManager.play_music_at_volume(__music, __volume, __cross_fade)
