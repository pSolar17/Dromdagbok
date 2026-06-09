extends Control

@export var progress : float = -1.0:
	set(value):
		progress = clamp(value, -1.0, 1.0)
		if $TextureRect:
			var progress_material : ShaderMaterial = $TextureRect.material
			progress_material.set_shader_parameter("progress", progress)

@export var invert : bool = false:
	set(value):
		invert = value
		if $TextureRect:
			var progress_material : ShaderMaterial = $TextureRect.material
			progress_material.set_shader_parameter("invert", invert)

var progress_ok : bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact") and progress_ok:
		progress_ok = false
		$AnimationPlayer.play("fade_out")
		await $AnimationPlayer.animation_finished
		await get_tree().create_timer(0.2).timeout
		if $TabContainer.current_tab == 2:
			await GUI.screen_fade_out().finished
			Global.tutorial_finished.emit()
			queue_free()
		else:
			$TabContainer.current_tab += 1
			$AnimationPlayer.play("fade_in")
			await $AnimationPlayer.animation_finished
			progress_ok = true

func _ready() -> void:
	MusicPlayer.main_player.stop()
	await get_tree().create_timer(0.5).timeout
	$AnimationPlayer.play("fade_in")
	progress_ok = true
