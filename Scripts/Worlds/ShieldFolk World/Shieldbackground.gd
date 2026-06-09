extends Sprite2D

@export var p_speed = 6

var p_frame = 0
var p_pass = 0

var offset_x : float = 0.0
var offset_y : float = 0.0

@onready var shader_material : ShaderMaterial = material

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	p_frame += 1
	
	if p_frame >= p_speed:
		p_frame -= p_speed
		p_pass += 1
		if p_pass % 2 == 0:
			offset_x += 0.75
		else:
			offset_y += 0.75
	
	shader_material.set_shader_parameter("offset_x", offset_x)
	shader_material.set_shader_parameter("offset_y", offset_y)
