extends Control


func _ready():
	get_node("/root/music").play_main_menu_music()
	$exit_button.visible = (OS.get_name() != "HTML5")


func _on_play_button_pressed():
	get_tree().change_scene("res://gameplay/main/main.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
