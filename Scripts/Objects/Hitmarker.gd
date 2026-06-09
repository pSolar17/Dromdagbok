extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitmarkerSound.play()
	await $HitmarkerSound.finished
	queue_free()
