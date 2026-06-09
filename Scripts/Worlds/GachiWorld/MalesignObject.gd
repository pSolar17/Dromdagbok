extends "res://Scripts/Objects/ObjectEffect.gd"

func _on_timer_timeout() -> void:
	$AnimatedSprite2D.play("wink")
	$Timer.start(Global.game_randi_range(3, 6))
