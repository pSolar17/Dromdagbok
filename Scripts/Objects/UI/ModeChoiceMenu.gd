extends Control

var transition_flag : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%ClassicButton.grab_focus()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		if not transition_flag:
			transition_flag = true
			$CancelSound.play()
			Global.change_level("world_mainmenu")



func _on_classic_button_focus_entered() -> void:
	$CursorSound.play()
	%ModeDescLabel.text = "LULE"

func _on_classic_button_pressed() -> void:
	if not transition_flag:
		transition_flag = true
		$OKSound.play()
		Global.mode = Global.GameMode.CLASSIC
		Global.change_level("event_tutorialstart")

func _on_quick_button_focus_entered() -> void:
	$CursorSound.play()
	%ModeDescLabel.text = "Fast & Furious"

func _on_quick_button_pressed() -> void:
	if not transition_flag:
		transition_flag = true
		$OKSound.play()
		Global.mode = Global.GameMode.QUICK
		Global.change_level("event_tutorialstart")
