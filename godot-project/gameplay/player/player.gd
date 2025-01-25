extends KinematicBody2D


export var speed: int = 500
var bubble_scene = preload("res://gameplay/bubble/bubble.tscn")
var n_bubbles = 1
signal player_died


func process_movement(delta):
	var velocity: Vector2 = Vector2.ZERO

	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 1

	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 1

	var collision = move_and_collide(speed * velocity * delta)
	if collision and (collision.collider.name == "font"):
		recharge_bubbles()


func process_shooting():
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("ui_shoot") and n_bubbles > 0:
		n_bubbles -= 1
		var bubble = bubble_scene.instance()
		get_parent().add_child(bubble)
		bubble.global_rotation = global_rotation
		bubble.global_position = $bubble_respawn.global_position


func recharge_bubbles():
	n_bubbles = 1


func _process(delta):
	process_movement(delta)
	process_shooting()


func die():
	emit_signal("player_died")
