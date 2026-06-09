extends Effect

var gpu_usage : int = 95

func effect():
	Global.ignore_player_input = true
	
	Global.money += 10
	$AnimatedSprite2D.play("mine")
	$PickaxeMine.play()
	await $AnimatedSprite2D.animation_finished
	$AnimationPlayer.stop()
	$CashRegister.play()
	$AnimationPlayer.play("TextAppear")
	await get_tree().create_timer(1.0).timeout
	
	Global.ignore_player_input = false

func update(_delta):
	var rand = Global.game_randi() % 180
	if rand == 0:
		gpu_usage = clamp(gpu_usage - 1, 90, 100)
		$CanvasLayer/Label.text = "GPU Usage: %d%%" % gpu_usage
	elif rand == 1:
		gpu_usage = clamp(gpu_usage + 1, 90, 100)
		$CanvasLayer/Label.text = "GPU Usage: %d%%" % gpu_usage
