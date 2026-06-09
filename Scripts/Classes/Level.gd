@tool

class_name Level
extends Node2D

## World size in pixels.
@export var world_size : Vector2 = Vector2(640, 640)
## Reference to the player Node. Set by the Game Node when loading the World.
@export var player : Character
## If true - can't use effects while in this world.
@export var block_effects : bool = false
## If true - this world is a part of Dream World.
@export var dream_world : bool = true

@export_group("Audio Settings")
## AudioStream that will be played in this world. If null - music will stop upon entering the level.
@export var level_track : AudioStream
## Pitch scale of level_track.
@export var pitch_scale : float = 1.0
## Volume of level_track. >3 means cancer.
@export var volume_db : float = 0.0

@export_group("Camera Settings")
@export var limit_left : int = -10000000
@export var limit_top : int = -10000000
@export var limit_right : int = 10000000
@export var limit_bottom : int = 10000000


# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.is_editor_hint():
		return
	
	if player:
		if player.camera:
			player.camera.limit_left = limit_left
			player.camera.limit_top = limit_top
			player.camera.limit_right = limit_right
			player.camera.limit_bottom = limit_bottom


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Engine.is_editor_hint():
		return
	
	#print(Engine.get_frames_per_second())
	
	#update_gameobjects()

func update_gameobjects():
	for child in get_children():
		if child is GameObject:
			child.update_position(player, world_size)

func _draw():
	if not (Engine.is_editor_hint() or Global.debug):
		return
	
	draw_rect(Rect2(Vector2.ZERO, world_size), Color.RED, false, 5.0)

func _enter_tree() -> void:
	if Engine.is_editor_hint():
		return
	
	await get_tree().physics_frame
	
	if level_track:
		MusicPlayer.play_track(level_track, pitch_scale, volume_db)
	else:
		if MusicPlayer.main_player:
			MusicPlayer.main_player.stop()
	
	Global.is_dream_world = dream_world
	
	if player == null:
		for child in get_children():
			if child is Character:
				player = child
				return
