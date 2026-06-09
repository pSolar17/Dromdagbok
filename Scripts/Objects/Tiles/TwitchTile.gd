extends GameObject

var idx : int = 1:
	set(value):
		idx = clamp(value, 1, 3)
		match idx:
			1:
				$Sprite1.visible = true
				$Sprite2.visible = false
				$Sprite3.visible = false
			2:
				$Sprite1.visible = false
				$Sprite2.visible = true
				$Sprite3.visible = false
			3:
				$Sprite1.visible = false
				$Sprite2.visible = false
				$Sprite3.visible = true

func _ready() -> void:
	idx = Global.game_randi_range(1, 3)

func cycle():
	idx = idx % 3 + 1
