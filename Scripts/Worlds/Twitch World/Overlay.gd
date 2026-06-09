extends Control

signal viewer_count_reached

var viewer_count : int = 1:
	set(value):
		viewer_count = clamp(value, 1, 69420)
		$ViewerCount.text = str(viewer_count)
		if value == viewer_count_target:
			viewer_count_reached.emit()

@export var viewer_count_target : int = 7200

func _physics_process(_delta: float) -> void:
	# Every frame, have a 1/69 chance to increase viewer count by 1 and 1/69 chance to decrease it by 1.
	# If Scamaz effect is active, it always increases the viewer count.
	# On 7200 viewers (2 minutes) unlock the passage to an effect.
	var rand = Global.game_randi() % 69
	if rand == 0:
		viewer_count += 1
	elif rand == 1:
		viewer_count -= 1
