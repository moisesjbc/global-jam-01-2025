extends Path2D

var enemy_scene = preload("res://gameplay/enemy/enemy.tscn")
var target
signal enemy_died


func _on_respawn_cooldown_timeout():
	randomize()
	$path_follow.unit_offset = randf()
	
	$appearance.play()
	var enemy = enemy_scene.instance()
	enemy.global_position = $path_follow.global_position
	enemy.target = target
	enemy.connect("enemy_died", self, "_on_enemy_death")
	$enemies.add_child(enemy)


func _on_enemy_death():
	print("respawn - enemy died")
	get_node("/root/sfx").play_enemy_death()
	emit_signal("enemy_died")
