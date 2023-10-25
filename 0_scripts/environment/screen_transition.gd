class_name ScreenTransition extends CanvasItem

signal on_loading_start

signal on_loading_finish

func transition_to_loading():
	visible = true
	var tween = create_tween()
	tween.tween_property(self, 'modulate:a', 1.0, 1)\
		.set_trans(Tween.TRANS_LINEAR)\
		.set_ease(Tween.EASE_OUT)\
		.finished.connect(__start_loading)
	
func transition_from_loading():
	var tween = create_tween()
	tween.tween_property(self, 'modulate:a', 0.0, 1)\
		.set_trans(Tween.TRANS_LINEAR)\
		.set_ease(Tween.EASE_IN)\
		.finished.connect(__finish_loading)

func __start_loading():
	on_loading_start.emit()
	
func __finish_loading():
	visible = false
	on_loading_finish.emit()
