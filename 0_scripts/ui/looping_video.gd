extends VideoStreamPlayer


func replay():
	self.stream_position = 0
	self.play()
