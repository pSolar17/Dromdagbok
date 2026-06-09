extends GameObject

func _on_interact_object_interacted_with(_interactor: Node2D) -> void:
	if not "effect_forsencd" in EffectManager.collected_effects:
		EffectManager.unlock_effect("effect_forsencd")
	
	$StaticBody2D/CollisionShape2D.disabled = false
	$AnimatedSprite2D.visible = true
