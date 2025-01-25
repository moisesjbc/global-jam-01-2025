extends ColorRect

signal abduction_finished


func _on_timer_timeout():
	emit_signal("abduction_finished")
