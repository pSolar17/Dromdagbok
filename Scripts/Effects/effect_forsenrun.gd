extends Effect

#func activate():
	#var player = Global.get_player()
	#if is_instance_valid(player):
		#player.speed *= 1.75
#
#func deactivate():
	#var player = Global.get_player()
	#if is_instance_valid(player):
		#player.speed /= 1.75

func update(_delta):
	var player = Global.get_player()
	if player.velocity != Vector2.ZERO:
		$AnimatedSprite2D.speed_scale = 1.0
	else:
		$AnimatedSprite2D.speed_scale = 0.0
		$AnimatedSprite2D.frame = 14
