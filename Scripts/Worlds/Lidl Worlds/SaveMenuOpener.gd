extends Node2D

func _on_interact_object_interacted_with(_interactor: Node2D) -> void:
	Global.cache_level()
	Global.change_level("event_savemenu")
