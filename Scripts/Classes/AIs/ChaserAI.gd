class_name ChaserAI
extends AI

# Class for all NPCs that chase the player.
# Extend and override methods to define custom behavior.

@export var base_speed : float = 200.0

@export var detection_delta : float = 32.0

var player : Character
var destination : Vector2
# 0 for horizontal, 1 for vertical
var current_direction : float = 0:
	set(value):
		current_direction = value
		speed = base_speed * randf_range(.9, 1.3)

var speed = base_speed

func get_velocity() -> Vector2:
	if not is_instance_valid(player):
		player = Global.get_player()
	else:
		destination = get_destination()
		var vect = destination - owner.global_position
		if current_direction == 0:
			if abs(vect.x) < detection_delta:
				current_direction = 1
			return Vector2(sign(vect.x) * speed, .0) * (0.7 + 0.25 * Global.mode)
		else:
			if abs(vect.y) < detection_delta:
				current_direction = 0
			return Vector2(.0, sign(vect.y) * speed) * (0.7 + 0.25 * Global.mode)
	
	return Vector2.ZERO

## Override this with pathing code.
func get_destination():
	return player.global_position
