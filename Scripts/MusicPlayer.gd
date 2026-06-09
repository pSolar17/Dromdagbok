extends Node

# Music player node.

@onready var main_player : AudioStreamPlayer = $MainPlayer
@onready var override_player : AudioStreamPlayer = $OverridePlayer

@onready var sound_player = $SoundPlayer
@onready var pos_sound_player = $PositionalSoundPlayer

## If true - will not play new tracks until unlocked.
@export var locked : bool = false

func play_track(track : AudioStream, p_scale : float = 1.0, volume : float = 0.0):
	if override_player.playing and override_player.volume_db > -80.0:
		return
	elif Global.true_end_flag:
		return
	
	main_player.stream = track
	main_player.pitch_scale = p_scale
	main_player.volume_db = volume
	main_player.play()

func play_track_override(track : AudioStream, p_scale : float = 1.0, volume : float = 0.0):
	main_player.stop()
	
	override_player.stream = track
	override_player.pitch_scale = p_scale
	override_player.volume_db = volume
	override_player.play()

func stop_track_override():
	override_player.stream = null
	override_player.stop()

func play_sound(sound : AudioStream, p_scale : float = 1.0, volume : float = 0.0):
	sound_player.stream = sound
	sound_player.pitch_scale = p_scale
	sound_player.volume_db = volume
	sound_player.play()

func play_sound_positional(sound : AudioStream, world_position : Vector2 = Vector2(320, 240), p_scale : float = 1.0, volume : float = 0.0):
	pos_sound_player.stream = sound
	pos_sound_player.global_position = world_position
	pos_sound_player.pitch_scale = p_scale
	pos_sound_player.volume_db = volume
	pos_sound_player.play()

func get_main_stream() -> AudioStream:
	if main_player:
		return main_player.stream
	else:
		return null

func get_override_stream() -> AudioStream:
	if override_player:
		return override_player.stream
	else:
		return null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Mute"):
		if AudioServer.get_bus_volume_db(0) == -80.0:
			AudioServer.set_bus_volume_db(0, 0.0)
		else:
			AudioServer.set_bus_volume_db(0, -80.0)
			
