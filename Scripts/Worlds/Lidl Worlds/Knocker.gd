extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Global.true_end_flag:
		queue_free()

func _on_timer_timeout() -> void:
	play()
