extends KinematicBody2D

var n_touching_enemies = 0
var font_abduction_scene = preload("res://gameplay/font_abduction/font_abduction.tscn")
var font_abduction: ColorRect
signal abduction_finished


func _on_influence_area_body_entered(body):
	if body.is_in_group("enemies"):
		n_touching_enemies += 1
		font_abduction = font_abduction_scene.instance()
		add_child(font_abduction)
		font_abduction.connect("abduction_finished", self, "_on_abduction_finished")


func _on_influence_area_body_exited(body):
	if body.is_in_group("enemies"):
		n_touching_enemies -= 1
		if n_touching_enemies == 0:
			font_abduction.disconnect("abduction_finished", self, "_on_abduction_finished")
			font_abduction.queue_free()


func _on_abduction_finished():
	emit_signal("abduction_finished")
