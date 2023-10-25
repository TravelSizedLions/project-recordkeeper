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
#	var last_track: AudioStream = SoundManager.get_currently_playing_music_tracks()[0]
#	if last_track == __intro or last_track == __main_loop:
#		last_track.finished.connect(__on_finished)
#	else:
	SoundManager.play_music(__intro, __cross_fade).finished.connect(__on_finished)

func __on_finished():
	SoundManager.play_music(__main_loop)
