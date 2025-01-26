extends Node2D


var score = 0


func _ready():
	$enemy_respawn.target = $font
	score = 0
	$gui.print_score(score)


func _on_font_abduction_finished():
	game_over()


func _on_player_player_died():
	game_over()


func game_over():
	get_node("/root/sfx").play_game_over()
	get_tree().reload_current_scene()


func _on_enemy_respawn_enemy_died():
	print("main - enemy died")
	score += 10
	$gui.print_score(score)
