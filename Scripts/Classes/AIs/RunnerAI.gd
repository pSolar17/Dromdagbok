extends AI
class_name RunnerAI

@export var speed : float = 128.0
@export var horizontal_only : bool = false
@export var wait : bool = false

var direction : Vector2 = Vector2.ZERO
var distance_traveled : float = 0.0
var distance : float = 0.0

var wait_counter : int = 0

func get_velocity() -> Vector2:
	if distance_traveled >= distance:
		distance_traveled = 0
		direction = Vector2(Global.game_randi() % 3 - 1, Global.game_randi() % 3 - 1)
		if direction == Vector2.ZERO:
			direction = Vector2.ONE
		if horizontal_only:
			direction.y = 0.0
		distance = (Global.game_randi() % 4 + 1) * 32
		if wait:
			wait_counter = 60 * Global.game_randf_range(1, 3)
	else:
		if wait_counter > 0:
			wait_counter -= 1
			return Vector2.ZERO
		
		distance_traveled += speed / 60.0 # Horrendous workaround.
		return direction.normalized() * speed
	
	return Vector2.ZERO
