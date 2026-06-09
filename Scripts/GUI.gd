extends CanvasLayer

func screen_fade_in(duration : float = 0.5) -> Tween:
	var tween = create_tween()
	tween.tween_property($BlackScreen, "modulate", Color("#ffffff", 0.0), duration)
	return tween

func screen_fade_out(duration : float = 0.5) -> Tween:
	var tween = create_tween()
	tween.tween_property($BlackScreen, "modulate", Color("#ffffff", 1.0), duration)
	return tween

func show_effect_text(effect_name : String):
	$EffectText.activate(effect_name)

func adjust_sound_levels():
	Global.pause_game()
	$AnimationPlayer.play("adjust_sound_levels")
	await $AnimationPlayer.animation_finished
	Global.unpause_game()
