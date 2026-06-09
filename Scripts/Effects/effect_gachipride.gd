extends Effect

var track = preload("res://Assets/Audio/Effects/THETIMEWIZARD.mp3")

var sound = preload("res://Assets/Audio/Effects/AAAAAAAAAAAAAAH.mp3")

func activate():
	await get_tree().process_frame
	
	if MusicPlayer.get_override_stream() != track:
		MusicPlayer.play_track_override(track)
	else:
		MusicPlayer.main_player.stop()
		MusicPlayer.override_player.volume_db = 0.0

func deactivate():
	MusicPlayer.override_player.volume_db = -80.0
	var level = Global.get_level()
	if is_instance_valid(level):
		MusicPlayer.play_track(level.level_track, level.pitch_scale, level.volume_db)

func effect():
	$BillyAhh.play()
