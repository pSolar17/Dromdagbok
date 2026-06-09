extends GameObject

@onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer

func _on_area_2d_body_entered(body):
	if body == Global.get_player():
		$AudioStreamPlayer.play()
