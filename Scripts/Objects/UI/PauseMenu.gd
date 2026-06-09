extends Control

enum State {
	CLOSED = 0,
	INFO,
	EFFECTS,
	QUIT,
	TRANSITION,
	COUNT,
}

const EXPERIENCE_TEXT = [
	"",
	"   0/  10", # 1
	"   4:  20", # 2
	"   9/  11", # 3
	" 444/4444", # 4
	"   3/  14", # 5
	"  21:  37", # 6
	"   7/  77", # 7
	"   2/  30", # 8
	"9001/9000", # 9
	"", # 10
	"", # 11
	"12/21 2012", # 12
	"Dec 13th 2024, Fri", # 13
	"  88/  14", # 14
	"   1/6 2021", # 15
	"forsen/  1337", # 16
	"", # 17
	"", # 18
]

@onready var effects_button = %EffectButton
@onready var quit_button = %QuitButton

@onready var sprite : Sprite2D = %EffectSprite
@onready var animated_sprite : AnimatedSprite2D = %EffectAnimatedSprite

@onready var char_name : Label = %Name
@onready var money : Label = %Money
@onready var effects : Label = %EffectCount
@onready var health : Label = %Health
@onready var experience : Label = %Experience

@onready var effect_container = %EffectButtonContainer

var current_effect : Effect = null

var state : State = State.CLOSED

var button_effects : Dictionary = {
	
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TabContainer.hide()
	

func _physics_process(_delta: float) -> void:
	pass

func _on_quit_button_pressed() -> void:
	if state == State.TRANSITION:
		return
	
	state = State.TRANSITION
	$OpenSound.play()
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	$TabContainer.current_tab = 2
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	%QuitYesButton.grab_focus.call_deferred()
	set_deferred("state", State.QUIT)

func _on_button_focus_entered() -> void:
	if state != State.TRANSITION:
		$CursorSound.play()

func _unhandled_input(event: InputEvent) -> void:
	# Can't open menu if no player is present
	if not is_instance_valid(Global.get_player()):
		return
	
	if event.is_action_pressed("Pause"):
		match state:
			State.CLOSED:
				# Can't open menu while input is disabled (e.g. cutscene is playing)
				if Global.ignore_player_input or Global.amonge_use_flag:
					return
				
				state = State.TRANSITION
				$OpenSound.play()
				update_info()
				update_effect_buttons()
				Global.pause_game()
				$AnimationPlayer.play("fade_out")
				await $AnimationPlayer.animation_finished
				$TabContainer.show()
				$TabContainer.current_tab = 0
				$AnimationPlayer.play("fade_in")
				await $AnimationPlayer.animation_finished
				%EffectButton.grab_focus.call_deferred()
				set_deferred("state", State.INFO)
			State.INFO:
				state = State.TRANSITION
				$CancelSound.play()
				$AnimationPlayer.play("fade_out")
				await $AnimationPlayer.animation_finished
				$TabContainer.hide()
				$AnimationPlayer.play("fade_in")
				await $AnimationPlayer.animation_finished
				state = State.CLOSED
				Global.unpause_game()
			State.QUIT:
				state = State.TRANSITION
				$CancelSound.play()
				$AnimationPlayer.play("fade_out")
				await $AnimationPlayer.animation_finished
				$TabContainer.current_tab = 0
				$AnimationPlayer.play("fade_in")
				await $AnimationPlayer.animation_finished
				%QuitButton.grab_focus.call_deferred()
				set_deferred("state", State.INFO)
			State.EFFECTS:
				state = State.TRANSITION
				$CancelSound.play()
				$AnimationPlayer.play("fade_out")
				await $AnimationPlayer.animation_finished
				$TabContainer.current_tab = 0
				$AnimationPlayer.play("fade_in")
				await $AnimationPlayer.animation_finished
				%EffectButton.grab_focus.call_deferred()
				set_deferred("state", State.INFO)
	
	get_viewport().set_input_as_handled()


func _on_quit_no_button_pressed() -> void:
	if state == State.TRANSITION:
		return
	
	state = State.TRANSITION
	$CancelSound.play()
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	$TabContainer.current_tab = 0
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	%QuitButton.grab_focus.call_deferred()
	set_deferred("state", State.INFO)


func _on_quit_yes_button_pressed() -> void:
	get_tree().quit()

func update_info():
	var player : Character = Global.get_player()
	if is_instance_valid(player):
		var effect : Effect = player.active_effect
		if is_instance_valid(effect):
			%Name.text = effect.get_effect_name()
			# Sprite work
			if effect.sprite:
				%EffectSprite.texture = effect.sprite.texture
				%EffectSprite.scale = effect.sprite.scale
			else:
				%EffectSprite.texture = null
			if effect.animated_sprite:
				%EffectAnimatedSprite.sprite_frames = effect.animated_sprite.sprite_frames
				%EffectAnimatedSprite.play(effect.animated_sprite.animation)
				%EffectAnimatedSprite.scale = effect.animated_sprite.scale
			else:
				%EffectAnimatedSprite.sprite_frames = null
	
	%Money.text = "%d kr" % Global.money
	var effect_count = EffectManager.get_collected_effects_count() + 1 # Account for fake tutorial effect
	%EffectCount.text = "E %d" % effect_count
	%Experience.text = EXPERIENCE_TEXT[min(effect_count, EXPERIENCE_TEXT.size() - 1)]
	
	# forsenGa effect
	if Global.recent_effect_id == "effect_forsenga":
		%QuitMessage.text = "Vill du sluta?"
		%QuitYesButton.text = "Ja"
		%QuitNoButton.text = "Nej"
		%EffectButton.text = "Effekter"
		%QuitButton.text = "Avsluta spelet"
	else:
		%QuitMessage.text = "Do you want to quit?"
		%QuitYesButton.text = "Yes"
		%QuitNoButton.text = "No"
		%EffectButton.text = "Effects"
		%QuitButton.text = "Quit Game"
		

func update_effect_buttons():
	button_effects.clear()
	for item in effect_container.get_children():
		if item.name != "TutorialItem":
			item.queue_free()
		else:
			var button : Button = item.get_node("Button")
			if button:
				if Global.true_end_flag:
					button.disabled = true
				else:
					button.disabled = false
	
	for effect_id in EffectManager.unlocked_effects:
		var effect = EffectManager.get_effect_by_id(effect_id)
		if not is_instance_valid(effect) or effect.hidden_effect:
			continue
		
		var effect_item = %TutorialItem.duplicate()
		%EffectButtonContainer.add_child(effect_item)
		
		var effect_button : Button = effect_item.get_node("Button")
		if not Global.is_dream_world or Global.get_level().block_effects:
			effect_button.disabled = true
		#effect_button.pressed.connect(_on_effect_item_button_pressed)
		#effect_button.focus_entered.connect(_on_effect_item_button_focus_entered)
		
		effect_button.text = effect.get_effect_name()
		button_effects[effect_button] = effect


func _on_effect_button_pressed() -> void:
	if state == State.TRANSITION:
		return
	
	state = State.TRANSITION
	$OpenSound.play()
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	$TabContainer.current_tab = 1
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	%TutorialItem/Button.grab_focus()
	set_deferred("state", State.EFFECTS)

func _on_effect_item_button_pressed() -> void:
	if state == State.TRANSITION:
		return
	
	for item in %EffectButtonContainer.get_children():
		var button : Button = item.get_child(0)
		
		if button.has_focus():
			if button.disabled:
				$NoSound.play()
				return
			
			if item.name == "TutorialItem":
				state = State.TRANSITION
				$AnimationPlayer.play("fade_out")
				await $AnimationPlayer.animation_finished
				hide()
				$AnimationPlayer.play("fade_in")
				await $AnimationPlayer.animation_finished
				Global.cache_level()
				Global.change_level("event_tutorial")
				await Global.tutorial_finished
				Global.set_level_to_cached()
				$AnimationPlayer.play("fade_out")
				await $AnimationPlayer.animation_finished
				show()
				$AnimationPlayer.play("fade_in")
				await $AnimationPlayer.animation_finished
				%TutorialItem/Button.grab_focus()
				state = State.EFFECTS
			
			var player = Global.get_player()
			if is_instance_valid(player):
				state = State.TRANSITION
				$OpenSound.play()
				$AnimationPlayer.play("fade_out")
				await $AnimationPlayer.animation_finished
				$TabContainer.hide()
				$AnimationPlayer.play("fade_in")
				await $AnimationPlayer.animation_finished
				state = State.CLOSED
				Global.unpause_game()
				
				var effect : Effect = button_effects[button]
				if effect.id == Global.recent_effect_id:
					player.active_effect = EffectManager.get_effect_by_id("effect_default")
					$EffectUnequip.play()
				else:
					player.active_effect = effect.duplicate()
					$EffectEquip.play()

func _on_effect_item_button_focus_entered() -> void:
	if state != State.TRANSITION:
		$CursorSound.play()
	
	for item in %EffectButtonContainer.get_children():
		var button : Button = item.get_child(0)
		if button.has_focus():
			if item.name == "TutorialItem":
				if Global.true_end_flag:
					%EffectDescriptionLabel.text = "[color=red]run.[/color]"
				else:
					%EffectDescriptionLabel.text = "Review the game's tutorial."
				return
			
			var effect : Effect = button_effects[button]
			%EffectDescriptionLabel.text = effect.effect_desc
