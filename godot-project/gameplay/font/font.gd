extends KinematicBody2D

var n_touching_enemies = 0
var font_abduction_scene = preload("res://gameplay/font_abduction/font_abduction.tscn")
var font_abduction: ColorRect
signal abduction_finished
var initial_shake_distance = 3.0
var initial_shake_speed = 50
var shake_distance = 3.0
var shake_speed = 50
var shake_step = 1


func _process(delta):
	if not $abduction_timer.is_stopped():
		$sprite.translate(Vector2(shake_distance * shake_speed * delta, 0.0))
		if (shake_distance > 0 and $sprite.position.x > shake_distance) or (shake_distance < 0 and $sprite.position.x < shake_distance):
			shake_distance *= -1
		shake_speed += shake_step * delta


func _on_influence_area_body_entered(body):
	if body.is_in_group("enemies"):
		n_touching_enemies += 1
		if n_touching_enemies == 1:
			shake_distance = initial_shake_distance
			shake_speed = initial_shake_speed
			$abduction_timer.start(2)


func _on_influence_area_body_exited(body):
	if body.is_in_group("enemies"):
		n_touching_enemies -= 1
		if n_touching_enemies == 0:
			$abduction_timer.stop()


func _on_abduction_timer_timeout():
	emit_signal("abduction_finished")
