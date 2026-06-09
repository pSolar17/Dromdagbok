extends AI
class_name WalkerAI

## Speed in pixels/sec.
@export var speed : float = 64.0

var destination : Vector2 = Vector2.INF

var wait_frames : int = 0

func get_velocity():
	var dist = (owner.global_position - destination).length_squared()
	if dist < 1.0 or destination == Vector2.INF:
		if wait_frames > 0:
			wait_frames -= 1
		else:
			wait_frames = Global.game_randi_range(60, 180)
			destination = owner.global_position + Vector2(32.0, 0) * Global.game_randi_range(-3, 3)
		return Vector2.ZERO
	else:
		return sign((owner.global_position - destination).x) * Vector2(speed, 0.0)
