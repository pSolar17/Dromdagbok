extends Node2D

signal true_end_reached

func _on_interact_object_interacted_with(_interactor: Node2D) -> void:
	if EffectManager.clone_machine_effects.is_empty():
		if EffectManager.collected_effects.is_empty():
			return
		for effect_id in EffectManager.collected_effects:
			EffectManager.remove_effect(effect_id)
			EffectManager.clone_machine_effects.append(effect_id)
		$EffectDeposited.play()
		if EffectManager.clone_machine_effects.size() >= Global.EFFECT_COUNT_FOR_ENDING:
			Global.true_end_flag = true
			$Explosion.play()
			EscapeSequenceHandler.escape_start()
			true_end_reached.emit()
	elif Global.true_end_flag == false:
		for effect_id in EffectManager.clone_machine_effects:
			EffectManager.unlock_effect(effect_id, false)
		EffectManager.clone_machine_effects.clear()
		$EffectReclaimed.play()

func _ready() -> void:
	if Global.true_end_flag:
		true_end_reached.emit()
