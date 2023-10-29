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
	if not is_already_playing():
		next_up = __main_loop
		SoundManager.play_music(__intro, __cross_fade).finished.connect((func(): MusicWithIntro.__on_finished()))

func is_already_playing():
	for stream in SoundManager.get_currently_playing_music():
		if stream.resource_path == __main_loop.resource_path or stream.resource_path == __intro.resource_path:
			return true
		
	return false

static func __on_finished():
	SoundManager.play_music(next_up)
