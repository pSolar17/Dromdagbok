extends GameObject

var pupil_start_pos : Vector2

func _ready() -> void:
	super._ready()
	
	pupil_start_pos = $EyePupil.position
	
	var rng = Global.game_randi() % 2
	if rng:
		$EyeBase.flip_h = true
		pupil_start_pos.x *= -1

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	var player = Global.get_player()
	if not is_instance_valid(player):
		return
	
	$EyePupil.position = pupil_start_pos + global_position.direction_to(player.global_position) * 2
