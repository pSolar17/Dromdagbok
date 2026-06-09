extends GameObject
class_name EffectObject

# Hint: connect signals from children nodes to unlock_effect() function.
# You might want to unbind some arguments for it to work

## Effect ID to unlock.
@export var effect_id : String

func unlock_effect():
	if not effect_id in EffectManager.collected_effects:
		EffectManager.unlock_effect(effect_id)
