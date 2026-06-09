extends Effect

func activate():
	Global.pause_game()

func _on_animated_sprite_2d_animation_finished() -> void:
	Global.change_level("world_start", 1) # In the bed
