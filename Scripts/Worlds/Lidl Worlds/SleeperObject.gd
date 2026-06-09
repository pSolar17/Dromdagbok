extends Node2D

func _on_area_2d_body_entered(_body: Node2D) -> void:
	# To prevent proccing immediately after waking up/entering the Dream World.
	if $GracePeriodTimer.time_left > 0.0:
		return
	# To prevent from going back into the Dream World during ending sequence.
	if Global.true_end_flag and not Global.is_dream_world:
		return
	
	$AnimationPlayer.play("count")

func _on_area_2d_body_exited(_body: Node2D) -> void:
	$AnimationPlayer.play("RESET")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "count":
		if Global.is_dream_world:
			Global.change_level("world_start", 1)
		else:
			Global.change_level("world_dreamstart", 0)
