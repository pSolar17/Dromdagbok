extends GameObject

var flag : bool = false

func _on_interact_object_interacted_with(_interactor : Node2D):
	if not flag:
		$AnimatedSprite2D.play("default")
		flag = true
