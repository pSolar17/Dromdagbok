extends Effect

var is_snowman : bool = false:
	set(value):
		is_snowman = value
		
		var player = Global.get_player()
		
		if value:
			$SadE.hide()
			$SadMan.show()
			$SnowmanOn.play()
			if is_instance_valid(player):
				player.speed = 12
			flip_sprite = false
		else:
			$SadE.show()
			$SadMan.hide()
			$SnowmanOff.play()
			if is_instance_valid(player):
				player.speed = 240
			flip_sprite = true

func activate():
	Global.weather = Global.Weather.SNOW

func deactivate():
	Global.weather = Global.Weather.NONE
	is_snowman = false
	#if is_instance_valid(Global.get_player()):
		#Global.get_player().speed = 240

func effect():
	is_snowman = !is_snowman
