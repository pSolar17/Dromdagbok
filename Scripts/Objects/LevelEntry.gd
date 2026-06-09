extends Marker2D

# Node that automatically places the player on its position upon level loading.

## Entry ID. If equal to -1 - will be deduced from the Entry's name.
@export var id : int = -1

func _ready() -> void:
	if id == -1:
		var suffix : String = name.trim_prefix("LevelEntry")
		if suffix.is_valid_int():
			id = int(suffix)
		elif suffix.is_empty():
			id = 0
	
	var player = Global.get_player()
	
	if is_instance_valid(player) and id == Global.recent_entry_id:
		player.global_position = global_position
