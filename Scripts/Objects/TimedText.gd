extends RichTextLabel

func _ready() -> void:
	if "effect_amonge" in EffectManager.collected_effects:
		text += " or use the amongE effect."

func _on_timer_timeout() -> void:
	visible = true
