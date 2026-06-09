extends Node

# In seconds.
@export var time_to_escape : float = 180.0

@onready var black_rect : TextureRect = $CanvasLayer/TextureRect
@onready var gradient_texture : GradientTexture2D = black_rect.texture
@onready var gradient : Gradient = gradient_texture.gradient

var progress : float = 0.0:
	set(value):
		progress = clamp(value, 0.0, 1.0)
		if progress == 1.0 and is_active and Global.true_end_flag:
			$EscapeMusic.stop()
			Global.change_level("world_credits", 0, 3.0)
			await Global.level_changed
			escape_stop()

var is_active : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.level_changed.connect(_on_level_changed)

func _physics_process(delta: float) -> void:
	if is_active:
		progress += 1.0 / time_to_escape * delta
	
	if progress <= 0.5:
		gradient.offsets[0] = 1.0 - progress * 2
		gradient.offsets[1] = 1.0
	elif progress >= 0.5:
		gradient.offsets[0] = 0.0
		gradient.offsets[1] = 1.0 - (progress - 0.5) * 2
	$EscapeMusic.volume_db = -30.0 + 30.0 * progress

func escape_start(reset : bool = true):
	if reset:
		progress = 0.0
	is_active = true
	$EscapeMusic.play()

func escape_stop(reset : bool = true):
	if reset:
		progress = 0.0
	is_active = false
	$EscapeMusic.stop()

func _on_level_changed(id : String):
	if id == "world_dreamstart" and is_active:
		progress = 0.8
	elif id == "world_start" and is_active and Global.true_end_flag:
		escape_stop()

func _input(event: InputEvent) -> void:
	if Global.debug and event.is_action_pressed("Debug"):
		if not is_active:
			escape_start()
		else:
			progress = 0.9
