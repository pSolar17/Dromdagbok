extends TileMapLayer

# Chunked TileMap that repeats endlessly in all directions.
# The tilemap should be positioned at (0, 0) to work correctly because I don't want to account for offset
# 	nor do I want to rewrite this in a way that makes sense

const SCREEN_TILE_SIZE : Vector2 = Vector2(20, 15)

@export var repeat_range : Vector2 = Vector2(41, 31)
@export var repeat_enabled : bool = true

var tiles : Dictionary = {}

func _ready() -> void:
	var cells = get_used_cells()
	
	for cell_xy in cells:
		tiles[cell_xy] = {
			"source_id" : get_cell_source_id(cell_xy),
			"atlas_coords" : get_cell_atlas_coords(cell_xy),
			"alternative_tile" : get_cell_alternative_tile(cell_xy),
		}

func _physics_process(_delta: float) -> void:
	clear()
	
	var player = Global.get_player()
	var level = Global.get_level()
	
	if not (is_instance_valid(player) and is_instance_valid(level)):
		return
	
	# This gives us precise player coordinates in TileMap's coordinate system...
	var player_tile : Vector2i = local_to_map(to_local(player.global_position))
	# ... and precise world size in tiles
	var world_tile_size = local_to_map(level.world_size)
	
	var top_left : Vector2i = player_tile - Vector2i(20, 15)
	for i in range(repeat_range.x):
		for j in range(repeat_range.y):
			var cur_cell_xy : Vector2 = top_left + Vector2i(i, j)
			
			if repeat_enabled:
				var original_cell_xy = Vector2i(cur_cell_xy.posmodv(world_tile_size))
				if original_cell_xy in tiles:
					set_cell(cur_cell_xy, tiles[original_cell_xy].source_id, tiles[original_cell_xy].atlas_coords, tiles[original_cell_xy].alternative_tile)
			else:
				if cur_cell_xy in tiles:
					set_cell(cur_cell_xy, tiles[cur_cell_xy].source_id, tiles[cur_cell_xy].atlas_coords, tiles[cur_cell_xy].alternative_tile)
