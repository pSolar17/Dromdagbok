extends Area2D

## If true - will only respond to player entering the Area.
@export var player_only : bool = true

## Level this trigger leads to.
@export var level_scene : PackedScene

## Entry this trigger leads to.
@export var entry_id : int = 0

func _on_body_entered(body):
	if player_only and body != Global.get_player():
		return
