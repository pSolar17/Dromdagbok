extends Level

func event():
	$GENERATINGNEWCLONE.stop()
	$CanvasModulate.visible = true

func _ready() -> void:
	super._ready()
	
	if Engine.is_editor_hint():
		return
	
	Global.true_end_flag_true.connect(event)
