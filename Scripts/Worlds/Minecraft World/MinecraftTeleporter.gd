extends Area2D

## Node the player will be teleported to.
@export var target : Node2D

func _on_player_entered(_body : Node2D):
	if is_instance_valid(target):
		teleport_player(target.global_position)

func teleport_player(where : Vector2):
	Global.pause_game()
	$CanvasLayer.visible = true
	$TeleportSound.play()
	$Timer.start()
	await $Timer.timeout
	
	var player = Global.get_player()
	if is_instance_valid(player):
		player.global_position = where
	
	$CanvasLayer.visible = false
	Global.unpause_game()
