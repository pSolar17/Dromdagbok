extends GameObject

@export var level_id : String = ""
@export var level_entry : int = 0

var door_sound = preload("res://Assets/Audio/door_openclose.ogg")

func _on_interact_object_interacted_with(_interactor: Node2D) -> void:
	if level_id == "world_inmemory":
		$AnimatedSprite2D.play("open")
		$OpenSound.play()
		Global.change_level(level_id, level_entry, 3.0)
	else:
		$AnimatedSprite2D.play("open")
		MusicPlayer.play_sound(door_sound)
		Global.change_level(level_id, level_entry)

func _ready() -> void:
	# For escape sequence.
	if Global.recent_level_id == "world_dreamstart" and Global.true_end_flag:
		queue_free()
	elif Global.recent_level_id == "world_start" and not Global.true_end_flag:
		queue_free()
