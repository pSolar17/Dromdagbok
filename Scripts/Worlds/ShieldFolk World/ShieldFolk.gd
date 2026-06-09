@tool
extends GameObject

@export_range(0, 11) var type : int = 0:
	set(value):
		type = value
		$AnimatedSprite2D.frame = type

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	super._physics_process(delta)
