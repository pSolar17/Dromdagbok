extends Label

var alive : int = 12

func _on_streamsniper_died():
	alive -= 1
	text = str(alive)
	# C OMEGALUL DING
	if alive == 1:
		Global.change_level("world_pubgwinner")
