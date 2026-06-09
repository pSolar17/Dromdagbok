extends GameObject

@export var level_id : String = ""
@export var level_entry : int = 0

func _on_teleport_area_2d_body_entered(body: Node2D) -> void:
	if body == Global.get_player():
		Global.change_level(level_id, level_entry)
