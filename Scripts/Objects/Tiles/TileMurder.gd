extends GameObject

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	$Sprite2D.modulate = Color(Color.WHITE, 0.75 + cos(Engine.get_physics_frames() * 2 * PI / 600.0 ) / 4.0)

func _draw() -> void:
	var level = Global.get_level()
	if not is_instance_valid(level):
		return
	
	for i in range(3):
		for j in range(3):
			draw_texture($Sprite2D.texture, global_position + level.world_size * Vector2(i - 1, j - 1), $Sprite2D.modulate)
