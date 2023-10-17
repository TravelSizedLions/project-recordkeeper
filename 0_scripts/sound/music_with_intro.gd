extends AudioStreamPlayer
class_name MusicWithIntro

@export var __main_loop: AudioStream

func on_finished():
	SoundManager.play_music(__main_loop)
