class_name GameObject
extends Node2D

# One problem associated with making a Yume Nikki-styled game is tied to creating seamless
# 	endless worlds.
# You need to make sure that objects do not appear from nowhere and do not disappear into nothingness.
# The solution I use is the following:
# - Each frame, calculate a new position that is closest to the player.
# - Change position to the one closest to the player.
# The main downside of this approach is that it doesn't quite work in small worlds(the size of main Viewport).
# This can be circumvented by cloning sprites of these world's objects.
# One other downside is that it may cause FPS drops if too many objects are present.

# IMPORTANT NOTE: GameObject should be direct children of Levels in order to update their position.
# Maybe I will rewrite code later so it's not the case.
# EDIT: the next day after writing this I actually fixed it OMEGALUL
# It shouldn't cause troubles if used correctly(i.e. Global.get_level() and Global.get_player() yield valid results).

## If true - the object will update it's position depending on the player's position.
@export var enabled : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Returns the difference between old and new position.
func update_position(player : Node2D, world_size : Vector2) -> Vector2:
	if not enabled:
		return Vector2.ZERO
	
	var changed : bool = true
	var new_pos = global_position
	var diff = Vector2.ZERO
	
	while(changed):
		new_pos = find_closest_position_to_player(player, world_size)
		if new_pos != global_position:
			changed = true
		else:
			changed = false
		
		diff = new_pos - global_position
		global_position = new_pos
	
	return diff

func find_closest_position_to_player(player : Node2D, world_size : Vector2) -> Vector2:
	var player_pos = player.global_position
	# Vector from object to player
	var player_vector : Vector2 = player_pos - global_position
	
	var new_pos : Vector2 = Vector2.ZERO
	
	# Calculate new x
	if abs(player_vector.x) <= world_size.x / 2:
		new_pos.x = global_position.x
	else:
		new_pos.x = global_position.x + world_size.x * sign(player_vector.x)
	
	# Calculate new y
	
	if abs(player_vector.y) <= world_size.y / 2:
		new_pos.y = global_position.y
	else:
		new_pos.y = global_position.y + world_size.y * sign(player_vector.y)
	
	return new_pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(_delta: float) -> void:
	var level = Global.get_level()
	if not is_instance_valid(level):
		return
	
	var player = level.player
	if not is_instance_valid(player):
		return
	
	update_position(player, level.world_size)
	pass
