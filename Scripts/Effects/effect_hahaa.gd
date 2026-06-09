extends Effect

const LINE_COLORS = [
	Color.CRIMSON,
	Color.ORANGE,
	Color.GOLD,
	Color.GREEN_YELLOW,
	Color.CORNFLOWER_BLUE,
	Color.NAVY_BLUE,
	Color.INDIGO,
]

var important_objects : Array[Node2D]
var offset = 0

var cur_object : Node2D

func activate():
	important_objects.clear()
	var group_objects = get_tree().get_nodes_in_group("Important")
	
	# Clear all objects that don't have a position
	for object in group_objects:
		if object is Node2D:
			important_objects.append(object)
	
	effect()

func effect():
	if important_objects.is_empty():
		return
	
	cur_object = important_objects[offset % important_objects.size()]
	$Line2D.default_color = LINE_COLORS[offset % LINE_COLORS.size()]
	$Line2D.default_color.a = 0.5
	
	offset += 1

func update(_delta):
	if cur_object:
		$Line2D.points[0] = cur_object.global_position - global_position
