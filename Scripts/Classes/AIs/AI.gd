class_name AI
extends Resource

## AIs are Resource objects that are intented to be used with NPC nodes.
## Classes derived from this one should redefine the get_velocity() method.
## Each frame, the owner NPC runs this method in its physics process method.

var owner : Node2D

func get_velocity() -> Vector2:
	return Vector2.ZERO
