extends Control


func _ready():
	get_node("/root/music").play_main_menu_music()


func _on_play_button_pressed():
	get_tree().change_scene("res://gameplay/main/main.tscn")
