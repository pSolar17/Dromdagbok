class_name NPC
extends GameObject

signal died

# Base class for all NPCs.

## If true - flips sprite to look at player
@export var flip : bool = false

## If true - can be killed with The Knife effect.
@export var killable : bool = true

@export var ai : AI = AI.new():
	set(value):
		ai = value
		if ai:
			ai.owner = self

var velocity : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if flip:
		var player = Global.get_player()
		if is_instance_valid(player):
			var dist_x = player.global_position.x - global_position.x
			if dist_x >= 0:
				scale.x = abs(scale.x);
			else:
				scale.x = -abs(scale.x);
	
	if Global.recent_effect_id == "effect_pointless":
		velocity = Vector2.ZERO
	elif is_instance_valid(ai):
		velocity = ai.get_velocity() * (-1 if Global.recent_effect_id == "effect_pagman" else 1)
	else:
		velocity = Vector2.ZERO
	
	global_position += velocity * delta

func _ready() -> void:
	if Global.true_end_flag:
		queue_free()

# Override this in derived classes to get custom death code
func die():
	if killable:
		Global.money += 10
		died.emit()
		queue_free()
