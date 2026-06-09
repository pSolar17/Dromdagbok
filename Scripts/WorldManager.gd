extends Node

# Global Node to manage worlds
# 	since Godot can't into cyclic PackedScene references OMEGALUL . o O ( forsenDespair )

#region Variables

## List of pairs ID - WorldScene, where ID is a String and WorldScene is a PackedScene containing the world. 
@export var worlds : Dictionary = {}

## List of pairs ID - EventScene, where ID is a String and EventScene is a PackedScene containing the world.
## There is no difference between a World and an Event, it's just done to separate them.
@export var events : Dictionary = {}

#region Functions

func get_world_by_id(id : String) -> PackedScene:
	for world_id in worlds:
		if world_id == id:
			return worlds[id]
	
	for event_id in events:
		if event_id == id:
			return events[id]
	
	print("WorldManager: couldn't find World with ID '%s', returning null." % id)
	return null
