extends RayCast2D

@export var length : float = 32.0

var direction : Vector2 = Vector2.RIGHT

func _unhandled_input(event: InputEvent) -> void:
	if Global.ignore_player_input:
		return
	
	if event.is_action_pressed("Interact"):
		var collider = get_collider()
		if collider is InteractObject:
			collider.interact(Global.get_player())

func _physics_process(delta: float) -> void:
	if Global.ignore_player_input:
		return
	
	var new_direction = Vector2(
		Input.get_axis("Left", "Right"),
		Input.get_axis("Up", "Down")
	)
	
	if new_direction != Vector2.ZERO:
		direction = new_direction
	
	target_position = length * direction

func _ready() -> void:
	collision_mask = 8 + 4 + 2
