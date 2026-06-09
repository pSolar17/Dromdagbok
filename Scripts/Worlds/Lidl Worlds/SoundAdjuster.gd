extends Node

func _enter_tree() -> void:
	if Global.show_adjust_volume:
		GUI.adjust_sound_levels()
		Global.show_adjust_volume = false
