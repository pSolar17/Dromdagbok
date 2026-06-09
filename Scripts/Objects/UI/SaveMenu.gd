extends Control

enum State {
	SAVES,
	TRANSITION,
}

var state = State.SAVES

# Called when the node enters the scene tree for the first time.
func _ready():
	update_save_slots()
	Global.show_adjust_volume = true
	%Page1Button.grab_focus()

func _on_button_focus_entered() -> void:
	if $NoButtonSoundTimer.time_left > 0.0:
		return
	$CursorSound.play()

func _unhandled_input(event: InputEvent) -> void:
	if state == State.TRANSITION:
		return
	
	if event.is_action_pressed("Pause"):
		state = State.TRANSITION
		await GUI.screen_fade_out(0.1).finished
		Global.set_level_to_cached()

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
		%Forsen1.visible = false
		%EffectHealth1.visible = false
	# Slot 2
	save_data = Global.get_save_data("2beta.sav")
	if Global.is_valid_save(save_data):
		collected_effects = save_data.get("collected_effects")
		%EffectHealth2.text = "E %d   ♥  1" % (collected_effects.size() + 1)
	else:
		%SaveSlotImage2.visible = false
		%Forsen2.visible = false
		%EffectHealth2.visible = false
	# Slot 3
	save_data = Global.get_save_data("3beta.sav")
	if Global.is_valid_save(save_data):
		collected_effects = save_data.get("collected_effects")
		%EffectHealth3.text = "E %d   ♥  1" % (collected_effects.size() + 1)
	else:
		%SaveSlotImage3.visible = false
		%Forsen3.visible = false
		%EffectHealth3.visible = false

func _on_page_1_button_pressed() -> void:
	if state == State.TRANSITION:
		return
	
	state = State.TRANSITION
	$OKSound.play()
	Global.save_game("1beta.sav")
	Global.set_level_to_cached()


func _on_page_2_button_pressed() -> void:
	if state == State.TRANSITION:
		return
	
	state = State.TRANSITION
	$OKSound.play()
	Global.save_game("2beta.sav")
	Global.set_level_to_cached()


func _on_page_3_button_pressed() -> void:
	if state == State.TRANSITION:
		return
	
	state = State.TRANSITION
	$OKSound.play()
	Global.save_game("3beta.sav")
	Global.set_level_to_cached()
