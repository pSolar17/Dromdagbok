extends TextureProgressBar

@export var sanity : float = 60.0

func _physics_process(delta: float) -> void:
	if MusicPlayer.override_player.volume_db > -80.0:
		sanity -= delta / 3
	else:
		sanity -= delta
	
	value = sanity
