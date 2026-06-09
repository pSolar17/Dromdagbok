extends Effect

const description = [
		"I'M NOT GAY",
		"UNLUCKY",
		"UNLOCK IT"
	]

func effect():
	$AnimatedSprite2D.play("default")
	$Unlucky.play()

func get_effect_desc():
	return description.pick_random()
