extends Effect

var hitmarker_scene : PackedScene = preload("res://Scenes/Objects/Common/Hitmarker.tscn")

func effect():
	if $CooldownTimer.time_left > 0.0:
		return
	
	$ShotSound.play()
	$AnimatedSprite2D.play("shoot")
	
	var collider = $ShapeCast2D.get_collider(0)
	if collider:
		if collider is InteractObject:
			if collider.collision_layer & 64 != 0:
				var hitmarker = hitmarker_scene.instantiate()
				Global.add_child(hitmarker)
				hitmarker.global_position = $ShapeCast2D.get_collision_point(0)
				collider.interact(self)
	
	$CooldownTimer.start()

func update(_delta):
	var direction = Input.get_axis("Left", "Right")
	
	if not is_equal_approx(direction, 0.0):
		$AnimatedSprite2D.flip_h = true if direction < 0.0 else false
		$AnimatedSprite2D.position.x = 32 * direction
		
		$ShapeCast2D.target_position.x = 160 * direction
		$ShapeCast2D.position.x = 17 * direction
		
		$Line2D.points[1] = 160 * Vector2(direction, 0.0)
		$Line2D.position.x = 17 * direction

func _process(_delta):
	pass # Override effect sprite flip from Effect class
