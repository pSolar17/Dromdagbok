extends Node

func _ready() -> void:
	if Global.debug:
		queue_free()
		return
	
	Global.pause_game()
	
	$CanvasLayer.visible = true
	$CanvasLayer/AnimatedSprite2D.play("default")
	await $CanvasLayer/AnimatedSprite2D.animation_finished
	
	Global.unpause_game()
	queue_free()
