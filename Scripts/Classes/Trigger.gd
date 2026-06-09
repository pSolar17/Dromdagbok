extends Area2D

@export var body_entered_object : Node
@export var body_entered_function_name : String

@export var body_exited_object : Node
@export var body_exited_function_name : String

@export var area_entered_object : Node
@export var area_entered_function_name : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)

func _on_body_entered(body : Node2D):
	pass

func _on_body_exited(body : Node2D):
	pass

func _on_area_entered(area : Area2D):
	pass

func _on_area_exited(area : Area2D):
	pass
