extends Node2D


func print_score(score):
	$score/label.text = str(score)


func print_time(elapsed_seconds):
	var minutes = elapsed_seconds / 60
	var seconds = elapsed_seconds % 60
	
	$time/label.text = "%d:%02d" % [minutes, seconds]


func _on_player_gun_emptied():
	$bubles/background_sprite_2/animation_player.play("bubles")


func _on_player_gun_reloaded():
	$bubles/background_sprite_2/animation_player.play("bubbles_up")
