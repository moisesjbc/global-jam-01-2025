extends Node2D


func print_score(score):
	$score/label.text = str(score)


func print_time(elapsed_seconds):
	var minutes = elapsed_seconds / 60
	var seconds = elapsed_seconds % 60
	
	$time/label.text = "%d:%02d" % [minutes, seconds]
