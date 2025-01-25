extends Node2D


func _ready():
	$enemy_respawn.target = $font


func _on_font_abduction_finished():
	game_over()


func _on_player_player_died():
	game_over()


func game_over():
	get_tree().reload_current_scene()
