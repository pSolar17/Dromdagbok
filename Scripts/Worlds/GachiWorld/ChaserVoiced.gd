extends NPC

@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D

## Voice lines that will play when player enters the search radius of the Chaser.
@export var voice : AudioStreamRandomizer = null

## Level ID that this Chaser teleports to upon catching the player.
@export var level_id : String = ""
## Level entry ID.
@export var level_entry : int = 0

func _ready() -> void:
	super._ready()
	audio_player.stream = voice

func _physics_process(delta: float) -> void:
	super._physics_process(delta)

func _on_sound_area_2d_body_entered(body: Node2D) -> void:
	if body == Global.get_player():
		audio_player.play()


func _on_teleport_area_2d_body_entered(body: Node2D) -> void:
	if body == Global.get_player():
		Global.change_level(level_id, level_entry)
