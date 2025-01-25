extends Node2D


func _ready():
	$enemy.target = $font


func _on_font_abduction_finished():
	get_tree().reload_current_scene()
