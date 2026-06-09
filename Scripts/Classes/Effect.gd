class_name Effect
extends Node2D

# Effects are Node2D's that are intended to use with EffectManager.
# Each effect has 4 functions:
# 	1. activate() - called when effect is activated. This only happens once.
# 	2. deactivate() - called when effect is deactivated(changed or dropped). This only happens once.
# 	3. update(delta) - called every physics frame. This is useful for effects that are applied constantly.
# 	4. effect() - called when effect is used('Z') by default.
# 	Overriding these functions should allow for all kinds of behavior one would desire.

## Effect ID. Used internally.
@export var id : String = "DEFAULT_ID"

## Effect name. Used when displaying in Effect Menu.
@export var effect_name : String = "DEFAULT_NAME":
	get = get_effect_name

## Effect description. Used when displaying in Effect Menu.
@export_multiline var effect_desc : String = "DEFAULT_DESC":
	get = get_effect_desc

## If true - can interact with things when effect is equipped.
@export var interact_enabled : bool = true

## If true - can wake up when using this effect.
@export var wakeup_enabled : bool = true

## If true - sprite will flip horizontally when moving.
@export var flip_sprite : bool = true

## If true - will detect sprite on ready if sprite is not set.
@export var auto_detect_sprite : bool = true

## Sprite node to flip.
@export var sprite : Sprite2D

## Animated Sprite node to flip.
@export var animated_sprite : AnimatedSprite2D

## If true - can't be selected or equipped from the effect menu.
@export var hidden_effect : bool = false

## If true - can't be used from the effect menu.
@export var unusable : bool = false


func _enter_tree():
	activate()
	Global.effect_activated.emit(id)

func _exit_tree():
	deactivate()

func _physics_process(delta: float) -> void:
	if is_inside_tree():
		update(delta)

func _process(_delta: float) -> void:
	if not Global.ignore_player_input:
		if flip_sprite and Input.is_action_pressed("Left"):
			if sprite:
				sprite.flip_h = true
			if animated_sprite:
				animated_sprite.flip_h = true
		elif flip_sprite and Input.is_action_pressed("Right"):
			if sprite:
				sprite.flip_h = false
			if animated_sprite:
				animated_sprite.flip_h = false

func _ready() -> void:
	if auto_detect_sprite and sprite == null:
		for child in get_children():
			if child is Sprite2D:
				sprite = child
			elif child is AnimatedSprite2D:
				animated_sprite = child

func _unhandled_input(event: InputEvent) -> void:
	if not is_inside_tree() or Global.ignore_player_input:
		return
	
	if event.is_action_pressed("Effect"):
		effect()
		Global.effect_used.emit(id)

## Overridable

func activate():
	pass

func deactivate():
	pass

func update(_delta : float):
	pass

func effect():
	pass

func get_effect_name():
	return effect_name

func get_effect_desc():
	return effect_desc
