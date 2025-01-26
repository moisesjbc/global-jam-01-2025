extends Node2D


var score = 0
var elapsed_seconds = 0


func _ready():
	get_node("/root/music").play_main_music()
	$enemy_respawn.target = $font
	
	set_score(0)
	set_elapsed_seconds(0)


func set_score(new_score):
	score = new_score
	$gui.print_score(score)
	

func set_elapsed_seconds(new_elapsed_seconds):
	elapsed_seconds = new_elapsed_seconds
	$gui.print_time(elapsed_seconds)


func _on_font_abduction_finished():
	game_over()


func _on_player_player_died():
	game_over()


func game_over():
	get_node("/root/sfx").play_game_over()
	get_tree().reload_current_scene()


func _on_enemy_respawn_enemy_died():
	set_score(score + 10)
	$gui.print_score(score)


func _on_game_timer_timeout():
	set_elapsed_seconds(elapsed_seconds + 1)
