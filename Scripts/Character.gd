class_name Character
extends CharacterBody2D

@export var speed : float = 240.0

@onready var camera : Camera2D = $Camera2D

var direction : Vector2 = Vector2.RIGHT

@export var active_effect : Effect:
	set(value):
		if not is_instance_valid(value):
			return
		
		#if value.id not in EffectManager.unlocked_effects:
			#return
		
		if is_instance_valid(active_effect):
			active_effect.queue_free()
		
		active_effect = value
		add_child(active_effect)
		Global.recent_effect_id = active_effect.id

## If true - player can move through most of the objects freely.
@export var noclip : bool = false:
	set(value):
		noclip = bool(value)
		if noclip:
			collision_mask = 32
		else:
			collision_mask = 2 + 4 + 16 + 32

# Called when the node enters the scene tree for the first time.
func _ready():
	var level = Global.get_level()
	if level:
		if level.dream_world and active_effect == null:
			var new_effect = EffectManager.get_effect_by_id(Global.recent_effect_id)
			if not new_effect or new_effect.hidden_effect:
				active_effect = EffectManager.get_effect_by_id("effect_default")
			else:
				active_effect = new_effect
		elif not level.dream_world:
			print("Not in a dream world; equip Forsen effect.")
			active_effect = EffectManager.get_effect_by_id("effect_forsen")
	else:
		active_effect = EffectManager.get_effect_by_id("effect_forsen")
		
	
	# Camera limits
	# 12.26.24: moved camera limits to Level.gd
	#if Global.recent_level_id == "world_vantrap":
		#$Camera2D.limit_top = 0
		#$Camera2D.limit_bottom = 480
	#elif Global.recent_level_id == "world_nexus":
		#pass
	#elif Global.recent_level_id in ["world_dreamstart", "world_start"]:
		#$Camera2D.limit_top = 0
		#$Camera2D.limit_bottom = 480
		#$Camera2D.limit_left = 0
		#$Camera2D.limit_right = 640

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Global.ignore_player_input:
		direction = Vector2.ZERO
	else:
		direction = Vector2(
			Input.get_axis("Left", "Right"),
			Input.get_axis("Up", "Down")
		)
	
	if direction != Vector2.ZERO:
		$RayCast2D.target_position = 32 * direction.normalized()
	
	velocity = direction.normalized() * speed * (0.5 + 0.275 * Global.mode)
	if active_effect and active_effect.id == "effect_forsenrun":
		velocity *= 1.75
	
	move_and_slide()
	#position = position.round()
	
	if is_instance_valid(active_effect):
		active_effect.update(delta)
	
	# pepeLaugh
	if "effect_pepelaugh" in EffectManager.unlocked_effects and Global.is_dream_world:
		if Global.game_randi() % 72000 == 0:
			print("pepeLaugh triggered!")
			pass # TODO: pepeLaugh random trigger handling
	
	# footsteps
	if velocity.length_squared() > 0.0 and not $FootstepSound.playing:
		$FootstepSound.play()

func _unhandled_input(event: InputEvent) -> void:
	if Global.ignore_player_input:
		return
	
	if event.is_action_pressed("Interact"):
		
		var collider = $RayCast2D.get_collider(0)
		if collider is InteractObject:
			collider.interact(self)
	
	elif event.is_action_pressed("WakeUp") and Global.is_dream_world and not Global.get_level().block_effects and not Global.true_end_flag:
		active_effect = EffectManager.get_effect_by_id("effect_forsengravity")
	
	#elif event.is_action_pressed("Debug"):
		#var effects_list_size = EffectManager.unlocked_effects.size()
		#active_effect = EffectManager.get_effect_by_id(EffectManager.unlocked_effects[(EffectManager.unlocked_effects.find(active_effect.id) + 1) % effects_list_size])
