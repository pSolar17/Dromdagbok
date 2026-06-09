extends NPC

@export var cancer_track : AudioStream

@export var death_sound : AudioStream

func _ready():
	super._ready()
	if cancer_track:
		$AudioStreamPlayer2D.stream = cancer_track
		$AudioStreamPlayer2D.play(Global.game_randf_range(0.0, cancer_track.get_length()))

func _on_teleport_area_2d_body_entered(_body: Node2D) -> void:
	Global.change_level("world_murder", 47)

func die():
	# Deactivate these
	ai = null
	$AudioStreamPlayer2D.stop()
	$TeleportArea2D.queue_free()
	$InteractObject.queue_free()
	
	if death_sound != null:
		$DeathSoundPlayer2D.stream = death_sound
		$DeathSoundPlayer2D.play()
		await $DeathSoundPlayer2D.finished
	
	super.die()
