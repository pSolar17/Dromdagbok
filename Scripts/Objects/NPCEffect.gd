extends NPC

@export var effect_id : String = ""

func _on_interact_object_interacted_with(_interactor: Node2D) -> void:
	if effect_id in EffectManager.collected_effects:
		return
	
	EffectManager.unlock_effect(effect_id)
