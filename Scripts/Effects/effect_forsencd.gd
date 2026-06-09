extends Effect

func activate():
	var player = Global.get_player()
	if is_instance_valid(player):
		player.noclip = true

func deactivate():
	var player = Global.get_player()
	if is_instance_valid(player):
		player.noclip = false
