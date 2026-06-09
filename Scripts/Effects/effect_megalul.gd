extends Effect

func update(_delta):
	MusicPlayer.main_player.pitch_scale = 0.33

func deactivate():
	var level : Level = Global.get_level()
	if is_instance_valid(level):
		MusicPlayer.main_player.pitch_scale = level.pitch_scale
