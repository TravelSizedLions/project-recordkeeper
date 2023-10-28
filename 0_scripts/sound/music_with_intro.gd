extends Triggerable
class_name MusicWithIntro

@export var __start_automatically: bool = true

@export var __intro: AudioStream
@export var __main_loop: AudioStream
@export var __cross_fade: float = 0

static var next_up

func _ready():
	if __start_automatically:
		__start()
	
func _on_trigger():
	__start()

func __start():
	next_up = __main_loop
	SoundManager.play_music(__intro, __cross_fade).finished.connect((func(): MusicWithIntro.__on_finished()))

static func __on_finished():
	SoundManager.play_music(next_up)
