extends Effect

# THIS WORKAROUND IS SO STUPID BUT IT WORKS
@export var workaround : float = 0.0:
	set(value):
		var mat : ShaderMaterial = $AmongE.material
		# Sprite height is 38, increase height shader parameter by 1/38 for every pixel below -3
		var diff : float = $AmongE.position.y + 3.0
		mat.set_shader_parameter("height", ceil(diff) / 38.0)

## Level ID that will be loaded
@export var where_to : String

## Level entry ID.
@export var entry_id : int = 420

func effect():
	if $AnimationPlayer.is_playing():
		return
	
	Global.amonge_use_flag = true
	Global.pause_game()
	$AnimationPlayer.play("hop_in")
	await $AnimationPlayer.animation_finished
	var ok = await Global.change_level(where_to, entry_id)
	if not ok:
		Global.unpause_game()
		$AnimationPlayer.play("RESET")

func activate():
	if Global.amonge_use_flag:
		Global.pause_game()
		Global.amonge_use_flag = false
		$AnimationPlayer.play("hop_out")
		await $AnimationPlayer.animation_finished
		Global.unpause_game()
