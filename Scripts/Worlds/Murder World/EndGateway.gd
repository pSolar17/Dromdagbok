extends GameObject


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == Global.get_player():
		Global.change_level("world_trueend")
