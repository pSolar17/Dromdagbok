extends Control

enum State {
	TITLE,
	SAVES,
	TRANSITION,
}

var state = State.TITLE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TabContainer.current_tab = 0
	update_save_slots()
	$AnimationPlayer.play("start")


func _on_button_focus_entered() -> void:
	if $NoButtonSoundTimer.time_left > 0.0:
		return
	$CursorSound.play()

func _on_new_game_button_pressed() -> void:
	if state == State.TRANSITION:
		return
	
	state = State.TRANSITION
	$OKSound.play()
	Global.change_level("world_modechoice")

func _on_dream_diary_button_pressed() -> void:
	if state == State.TRANSITION:
		return
	
	$OKSound.play()
	state = State.TRANSITION
	await GUI.screen_fade_out(0.1).finished
	$TabContainer.current_tab = 1
	state = State.SAVES
	$NoButtonSoundTimer.start(0.05)
	%Page1Button.grab_focus()
	GUI.screen_fade_in(0.1)

func _on_quit_button_pressed() -> void:
	if state == State.TRANSITION:
		return
	
	$OKSound.play()
	state = State.TRANSITION
	await GUI.screen_fade_out(1.0).finished
	get_tree().quit()

func _unhandled_input(event: InputEvent) -> void:
	if state == State.TRANSITION:
		return
	
	if event.is_action_pressed("Pause"):
		if state == State.SAVES:
			state = State.TRANSITION
			$CancelSound.play()
			await GUI.screen_fade_out(0.1).finished
			$TabContainer.current_tab = 0
			state = State.TITLE
			$NoButtonSoundTimer.start(0.05)
			%DreamDiaryButton.grab_focus()
			GUI.screen_fade_in(0.1)

func update_save_slots():
	var save_data
	var collected_effects : Array
	# Slot 1
	save_data = Global.get_save_data("1beta.sav")
	if Global.is_valid_save(save_data):
		collected_effects = save_data.get("collected_effects")
		%EffectHealth1.text = "E %d   ♥  1" % (collected_effects.size() + 1)
	else:
		%SaveSlotImage1.visible = false
		%Page1Button.disabled = true
		%Forsen1.visible = false
		%EffectHealth1.visible = false
	# Slot 2
	save_data = Global.get_save_data("2beta.sav")
	if Global.is_valid_save(save_data):
		collected_effects = save_data.get("collected_effects")
		%EffectHealth2.text = "E %d   ♥  1" % (collected_effects.size() + 1)
	else:
		%SaveSlotImage2.visible = false
		%Page2Button.disabled = true
		%Forsen2.visible = false
		%EffectHealth2.visible = false
	# Slot 3
	save_data = Global.get_save_data("3beta.sav")
	if Global.is_valid_save(save_data):
		collected_effects = save_data.get("collected_effects")
		%EffectHealth3.text = "E %d   ♥  1" % (collected_effects.size() + 1)
	else:
		%SaveSlotImage3.visible = false
		%Page3Button.disabled = true
		%Forsen3.visible = false
		%EffectHealth3.visible = false

func _on_page_1_button_pressed() -> void:
	if %Page1Button.disabled:
		return
	
	$OKSound.play()
	Global.load_game("1beta.sav")


func _on_page_2_button_pressed() -> void:
	if %Page2Button.disabled:
		return
	
	$OKSound.play()
	Global.load_game("2beta.sav")


func _on_page_3_button_pressed() -> void:
	if %Page3Button.disabled:
		return
	
	$OKSound.play()
	Global.load_game("3beta.sav")
