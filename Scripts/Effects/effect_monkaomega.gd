extends Effect

const EXCLUDE_WORLDS = [
	"world_vantrap",
	"world_nexus",
	"world_minecraft",
]

func effect():
	var player : Character = Global.get_player()
	var camera : Camera2D = player.camera
	if camera and Global.recent_level_id not in EXCLUDE_WORLDS:
		camera.zoom = (camera.zoom - Vector2.ONE / 4.0)
		if camera.zoom.x < 0.45:
			camera.zoom = Vector2.ONE
	elif camera and Global.recent_level_id in EXCLUDE_WORLDS:
		$NoSound.play()

func deactivate():
	var player : Character = Global.get_player()
	var camera : Camera2D = player.camera
	camera.zoom = Vector2.ONE
