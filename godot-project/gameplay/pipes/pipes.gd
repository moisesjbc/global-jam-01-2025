extends TileMap

var pipe_glow_scene = preload("res://gameplay/pipe_glow/pipe_glow.tscn")

export var min_x: int
export var max_x: int
export var min_y: int
export var max_y: int


func _ready():
	spawn_glow(0)
	spawn_glow(1)
	spawn_glow(2)
	spawn_glow(3)


func random_number_in_range(min_n, max_n):
	randomize()
	return (randi() % (max_n - min_n)) + min_x


func spawn_glow(sector):
	#randomize()
	#var sector: int = randi() % 4
	var tile_relative_position = Vector2.ZERO
	if sector == 0:
		# Left
		tile_relative_position.x = min_x - 1
		tile_relative_position.y = random_number_in_range(min_y, max_y)
	elif sector == 1:
		# Right
		tile_relative_position.x = max_x + 1
		tile_relative_position.y = random_number_in_range(min_y, max_y)
	elif sector == 2:
		# Top
		tile_relative_position.y = min_y - 1
		tile_relative_position.x = random_number_in_range(min_x, max_x)
	else:
		# Bottom
		tile_relative_position.y = max_y + 1
		tile_relative_position.x = random_number_in_range(min_x, max_x)

	var tile_pos = map_to_world(tile_relative_position) * 0.1 + Vector2(-30, -30)
	var pipe_glow = pipe_glow_scene.instance()
	get_parent().call_deferred("add_child", pipe_glow)
	pipe_glow.connect("tree_exited", self, "_on_pipe_glow_destroyed", [sector])
	pipe_glow.global_position = tile_pos


func _on_pipe_glow_destroyed(sector):
	spawn_glow(sector)
