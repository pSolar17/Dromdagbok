extends Effect

func get_effect_name():
	if Global.game_randf() > 0.5:
		return "PagMan"
	else:
		return "PauseMan"
