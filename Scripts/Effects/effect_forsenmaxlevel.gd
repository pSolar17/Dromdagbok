extends Effect

func effect():
	if not $Thunder.playing:
		$Thunder.play()
		$AnimatedSprite2D.play("default")
