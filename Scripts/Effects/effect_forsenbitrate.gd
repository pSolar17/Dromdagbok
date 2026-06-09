extends Effect

func effect():
	if not $AudioStreamPlayer.playing:
		$AnimatedSprite2D.play("default")
		$AudioStreamPlayer.play()

func activate():
	AudioServer.set_bus_effect_enabled(0, 0, true)
	AudioServer.set_bus_effect_enabled(0, 1, true)
	AudioServer.set_bus_effect_enabled(0, 2, true)

func deactivate():
	AudioServer.set_bus_effect_enabled(0, 0, false)
	AudioServer.set_bus_effect_enabled(0, 1, false)
	AudioServer.set_bus_effect_enabled(0, 2, false)
