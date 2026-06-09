extends Node

# Global Node that manages Effects.
# It keeps track of the current Effect, calling its update(delta) function.
# It also stores info about unlocked Effects. Effects that are not unlocked cannot be set as active.

## Array of effects recognized by the game. If you want to mod this game(why would you LUL),
## 		either decompile it and assign new effects in the Editor or use API(Global.gd).
@export var effect_scenes : Array[PackedScene] = []

@export var unlocked_effects : Array[String] = [
	"effect_default",
	"effect_forsenness",
	"effect_forsengravity",
]

## Collection of Effect IDs that have been collected.
## They are not reset when dropping effects.
## This is used to mark effects that have been collected and dropped in the Clone Machine.
@export var collected_effects : Array[String] = [
]

## For Clone Machine purposes.
var clone_machine_effects : Array[String] = []

var effects : Dictionary = {}

func unlock_effect(id : String, show_message : bool = true):
	if not id in effects:
		return
	
	if not id in collected_effects:
		collected_effects.append(id)
	
	if not id in unlocked_effects:
		unlocked_effects.append(id)
		if show_message:
			GUI.show_effect_text(get_effect_by_id(id).effect_name)

func remove_effect(id : String, remove_collected : bool = false):
	if id == "effect_default":
		return
	
	unlocked_effects.erase(id)
	if id == Global.recent_effect_id:
		var player = Global.get_player()
		if is_instance_valid(player):
			player.active_effect = get_effect_by_id("effect_default")
	
	if remove_collected:
		collected_effects.erase(id)

func get_effect_by_name(effect_name : String) -> Effect:
	for effect in effects:
		if effect is Effect and effect.effect_name == effect_name:
			return effect.duplicate()
	return null

func get_effect_by_id(id : String) -> Effect:
	if id in effects:
		var effect : Effect = effects[id]
		return effect.duplicate()
	
	return null

func _ready() -> void:
	for scene in effect_scenes:
		if scene is not PackedScene:
			continue
		
		var effect = scene.instantiate()
		if effect is Effect:
			effects[effect.id] = effect
	
	if Global.debug:
		for effect_id in effects:
			unlock_effect(effect_id)

func get_collected_effects_count():
	var count = 0
	for effect_id in collected_effects:
		if get_effect_by_id(effect_id).hidden_effect:
			continue
		count += 1
	
	return count
