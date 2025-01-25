extends TileMap

var pipe_glow_scene = preload("res://gameplay/pipe_glow/pipe_glow.tscn")

func _ready():
	var tile_pos = map_to_world(Vector2(5,1)) + Vector2(32, 32)
	var pipe_glow = pipe_glow_scene.instance()
	add_child(pipe_glow)
	pipe_glow.global_position = tile_pos
