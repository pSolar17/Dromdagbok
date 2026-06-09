extends GameObject

@export var level_id : String = ""
@export var level_entry : int = 0

var door_sound : AudioStream = preload("res://Assets/Audio/door_openclose.ogg")

func _on_interact_object_interacted_with(_interactor: Node2D) -> void:
	Global.pause_game()
	$AudioStreamPlayer.play()
	var tween = get_tree().create_tween().bind_node(self).set_parallel(true).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN)
	tween.tween_property($NexusEffect, "modulate", Color.WHITE, 1.5)
	tween.tween_property($NexusEffect, "scale", Vector2(0.6, 0.6), 1.5) # Account for x2 scale on all doors
																		# Peak coding OMEGALYL
	await tween.finished
	$AnimatedSprite2D.play("open")
	MusicPlayer.play_sound(door_sound, 1.0, 0.0)
	
	var check = await Global.change_level(level_id, level_entry)
	if not check:
		Global.unpause_game()
