extends Node
class_name LevelChanger

## Level ID to change to.
@export var world_id : String = ""

## Entry ID to place the player at.
@export var entry_id : int = 0

# Hint: connect signals from other nodes to this Node's change_level function.
# You might want to unbind some arguments

func change_level():
	Global.change_level(world_id, entry_id)
