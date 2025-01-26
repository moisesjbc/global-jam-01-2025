extends Node


func _ready():
	play_main_menu_music()


func play_main_music():
	if not $in_game_music.playing:
		$main_menu_music.stop()
		$in_game_music.play()


func play_main_menu_music():
	if not $main_menu_music.playing:
		$in_game_music.stop()
		$main_menu_music.play()
