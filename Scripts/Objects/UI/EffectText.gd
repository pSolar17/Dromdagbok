extends Control

var closable = false

func activate(label_text : String = ""):
	Global.pause_game()
	$EffectObtained.play()
	$VBoxContainer/RichTextLabel.text = "[center]%s" % label_text
	$AnimationPlayer.play("show")

func _input(event):
	if not visible:
		return
	
	if event.is_action_pressed("Interact") and closable:
		$AnimationPlayer.play("hide")
		Global.unpause_game()
	elif event.is_action_pressed("Interact") and not closable:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("RESET")
		closable = true
	
	get_viewport().set_input_as_handled()

func _ready() -> void:
	hide()
	pass
