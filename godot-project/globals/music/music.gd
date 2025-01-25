extends Node


func _ready():
	play_main_music()


func play_main_music():
	$in_game_music.play()
