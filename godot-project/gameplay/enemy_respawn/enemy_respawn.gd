extends Path2D

var enemy_scene = preload("res://gameplay/enemy/enemy.tscn")
var target
signal enemy_died
var respawn_seconds = 4
var initial_speed = 120


func _on_respawn_cooldown_timeout():
	randomize()
	$path_follow.unit_offset = randf()
	$respawn_cooldown.start(respawn_seconds)
	
	$appearance.play()
	var enemy = enemy_scene.instance()
	enemy.initial_speed = initial_speed
	enemy.global_position = $path_follow.global_position
	enemy.target = target
	enemy.connect("enemy_died", self, "_on_enemy_death")
	$enemies.add_child(enemy)


func _on_enemy_death():
	get_node("/root/sfx").play_enemy_death()
	emit_signal("enemy_died")


func _on_difficulty_timer_timeout():
	if respawn_seconds >= 1:
		respawn_seconds -= 0.5
		initial_speed += 20
