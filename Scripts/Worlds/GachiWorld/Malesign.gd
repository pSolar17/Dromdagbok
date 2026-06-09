extends Node3D

@export var rotation_speed : float = 180.0

func _physics_process(delta: float) -> void:
	rotation.y += deg_to_rad(rotation_speed) * delta
