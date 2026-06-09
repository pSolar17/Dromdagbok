extends Effect

var direction_name : String = "down"
var action_name : String = "idle"

func update(_delta):
	var direction = Vector2(
		Input.get_axis("Left", "Right"),
		Input.get_axis("Up", "Down")
	)
	
	if direction != Vector2.ZERO:
		direction_name = ""
	
		if direction.y < 0.0:
			direction_name += "up"
		elif direction.y > 0.0:
			direction_name += "down"
		
		if direction.x > 0.0:
			direction_name += "right"
		elif direction.x < 0.0:
			direction_name += "left"
	
	if direction == Vector2.ZERO:
		action_name = "idle"
	else:
		action_name = "walk"
	
	$AnimatedSprite2D.play("%s_%s" % [action_name, direction_name])
