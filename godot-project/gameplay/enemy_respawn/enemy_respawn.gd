extends Path2D

var enemy_scene = preload("res://gameplay/enemy/enemy.tscn")
var target


func _on_respawn_cooldown_timeout():
	randomize()
	$path_follow.unit_offset = randf()
	
	var enemy = enemy_scene.instance()
	enemy.global_position = $path_follow.global_position
	enemy.target = target
	$enemies.add_child(enemy)


func _on_enemy_death():
	$enemy_death.play()
