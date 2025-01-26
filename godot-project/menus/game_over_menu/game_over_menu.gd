extends Control


func _on_restart_button_pressed():
	restart()


func _input(event):
	if event is InputEventKey and visible:
		if event.scancode == KEY_SPACE:
			restart()
		elif event.scancode == KEY_ESCAPE:
			exit()


func start():
	visible = true
	get_tree().paused = true


func restart():
	get_tree().paused = false
	get_tree().change_scene("res://gameplay/main/main.tscn")
	
func exit():
	get_tree().paused = false
	get_tree().change_scene("res://menus/main_menu/main_menu.tscn")

func _on_exit_button_pressed():
	exit()
