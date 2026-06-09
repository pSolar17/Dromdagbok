extends InteractObject


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.effect_used.connect(_on_effect_used)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_interacted_with(_interactor: Node2D) -> void:
	if $AnimatedSprite2D.frame != 1:
		$AnimatedSprite2D.frame = ($AnimatedSprite2D.frame + 2) % 4

func _on_effect_used(id : String):
	if id == "effect_forsenpls":
		$AnimatedSprite2D.frame = 1
