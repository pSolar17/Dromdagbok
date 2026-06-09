extends Node

#region Signals

signal tutorial_finished
signal effect_activated(effect_id : String)
signal effect_used(effect_id : String)
signal true_end_flag_true

signal level_changed(id : String)

#region Constants

enum GameMode {
	CLASSIC = 1,
	QUICK = 2,
}

enum Weather {
	NONE = 0,
	RAIN = 1,
	SNOW = 2,
}

const EFFECT_COUNT_FOR_ENDING = 8

#endregion

#region Game Parameters

@export var version : String = "0.1"

@export var debug : bool = false

@export var ignore_player_input : bool = false

@export var recent_entry_id : int = 0
@export var recent_level_id : String = "world_start"
@export var recent_effect_id : String = "effect_default"

## Game mode.
@export var mode : GameMode = GameMode.CLASSIC

## Whether in Dream World or not
@export var is_dream_world : bool = true

## If true - amongE was used, play appear animation upon next activation
@export var amonge_use_flag : bool = false

## Serves no purpose other than displaying in pause menu. Obtain money by killing NPCs.
@export var money : int = 0

## Level switch flag. Only true when changing levels, disables certain things like effect equip sounds
@export var change_level_flag : bool = false

## True ending flag
@export var true_end_flag : bool = false

## Current weather. Does not affects graphics; it's just a variable.
@export var weather : Weather = Weather.NONE

## Adjust volume flag. If true - adjust volume graphic will be shown upon entering the game.
@export var show_adjust_volume : bool = true

#endregion

#region Runtime stuff

var cached_level : Level

#endregion

#region API/Functions

func get_level() -> Level:
	var current_scene = get_tree().get_current_scene()
	if current_scene is Level:
		return current_scene
	else:
		return null

func get_player() -> Character:
	var level : Level = get_level()
	if is_instance_valid(level):
		return level.player
	return null

func change_level(level_id : String, entry_id : int = 0, transition_time : float = 0.5) -> bool:
	var level_scene = WorldManager.get_world_by_id(level_id)
	if level_scene == null:
		return false
	
	change_level_flag = true
	
	recent_entry_id = entry_id
	recent_level_id = level_id
	
	pause_game()
	
	await GUI.screen_fade_out(transition_time).finished
	
	get_tree().change_scene_to_packed(level_scene)
	
	get_tree().paused = false
	level_changed.emit(level_id)
	
	await get_tree().physics_frame
	ignore_player_input = false
	change_level_flag = false
	
	await GUI.screen_fade_in(transition_time).finished
	
	return true

func game_randi():
	if recent_effect_id == "effect_scamaz":
		return 69
	else:
		return randi()

func game_randf():
	if recent_effect_id == "effect_scamaz":
		return 69.0
	else:
		return randf()

func game_randi_range(from : int, to : int):
	if recent_effect_id == "effect_scamaz":
		return 69
	else:
		return randi_range(from, to)

func game_randf_range(from : float, to : float):
	if recent_effect_id == "effect_scamaz":
		return 69.0
	else:
		return randf_range(from, to)

func pause_game():
	ignore_player_input = true
	get_tree().paused = true

func unpause_game():
	ignore_player_input = false
	get_tree().paused = false

func save_game(save_file_name : String):
	var file = FileAccess.open("user://%s" % save_file_name, FileAccess.WRITE)
	var game_data : Dictionary = {
		"version" : version,
		"world" : "world_start",
		"entry" : 0,
		"effect" : "effect_forsen",
		"money" : money,
		"mode" : mode,
		"collected_effects" : EffectManager.collected_effects,
		"unlocked_effects" : EffectManager.unlocked_effects,
		"clone_machine_effects" : EffectManager.clone_machine_effects,
		"true_end" : true_end_flag,
	}
	
	file.store_var(game_data)

func load_game(save_file_name : String):
	var file = FileAccess.open("user://%s" % save_file_name, FileAccess.READ)
	var game_data = file.get_var()
	
	if game_data is Dictionary:
		version = game_data.get("version")
		recent_level_id = game_data.get("world")
		recent_entry_id = game_data.get("entry")
		recent_effect_id = game_data.get("effect")
		money = int(game_data.get("money"))
		mode = game_data.get("mode") as GameMode
		EffectManager.collected_effects = game_data.get("collected_effects")
		EffectManager.unlocked_effects = game_data.get("unlocked_effects")
		EffectManager.clone_machine_effects = game_data.get("clone_machine_effects")
		true_end_flag = game_data.get("true_end")
		if EffectManager.collected_effects.size() < EFFECT_COUNT_FOR_ENDING:
			true_end_flag = false
	
	change_level(recent_level_id, recent_entry_id)

func get_save_data(save_file_name : String):
	var file = FileAccess.open("user://%s" % save_file_name, FileAccess.READ)
	var game_data = null
	if file:
		game_data = file.get_var()
	if game_data is not Dictionary:
		return {}
	
	return game_data

func is_valid_save(game_data : Dictionary):
	if game_data.get("version") is not String:
		return false
	if game_data.get("entry") is not int:
		return false
	var world = game_data.get("world")
	if world is not String or world not in WorldManager.worlds:
		return false
	var effect = game_data.get("effect")
	if effect is not String or not EffectManager.get_effect_by_id(effect):
		return false
	if game_data.get("money") is not int:
		return false
	
	return true

func cache_level():
	var level = get_level()
	if not level:
		return
	
	await GUI.screen_fade_out().finished
	
	cached_level = level
	get_viewport().remove_child(level)

func set_level_to_cached():
	if cached_level:
		pause_game()
		
		await GUI.screen_fade_out().finished
		
		if get_tree().current_scene:
			get_tree().current_scene.queue_free()
		get_viewport().add_child(cached_level)
		get_tree().current_scene = cached_level
		
		get_tree().paused = false
		await GUI.screen_fade_in().finished
		ignore_player_input = false

#endregion

#region Functions override

func _input(event):
	if event.is_action_pressed("Debug") and debug:
		save_game("1beta.sav")
	elif event.is_action_pressed("Save") and debug:
		load_game("1beta.sav")
	elif event.is_action_pressed("Fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

# Game set-up
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	pass

func _process(_delta: float) -> void:
	pass
	#print(Engine.get_frames_per_second())

#endregion
