extends Triggerable

func _on_trigger():
	var particle_system: CPUParticles2D = N.get_child(self, CPUParticles2D)
	if particle_system:
		particle_system.emitting = true
		particle_system.modulate = Color.WHITE
		get_tree().create_tween()\
			.tween_property(particle_system, 'modulate:a', 0, particle_system.lifetime)\
			.set_ease(Tween.EASE_IN_OUT)\
			.set_trans(Tween.TRANS_SINE)
		
	
	
