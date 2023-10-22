extends Triggerable
class_name MusicWithIntro

@export var __start_automatically: bool = true

@export var __intro: AudioStream
@export var __main_loop: AudioStream
@export var __cross_fade: float = 0

func _ready():
	if __start_automatically:
		__start()
	
func _on_trigger():
	__start()

func __start():
	SoundManager.play_music(__intro, __cross_fade).finished.connect(__on_finished)

func __on_finished():
	SoundManager.play_music(__main_loop)
