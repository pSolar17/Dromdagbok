extends Effect

#func _physics_process(_delta: float) -> void:
	#var direction = Vector2(
		#Input.get_axis("Left", "Right"),
		#Input.get_axis("Up", "Down")
	#)
	#
	#if direction != Vector2.ZERO:
		#$RayCast2D.target_position = direction * 32
#
#func effect():
	#var collider = $RayCast2D.get_collider()
	#if collider is InteractObject:
		#collider.interact()
