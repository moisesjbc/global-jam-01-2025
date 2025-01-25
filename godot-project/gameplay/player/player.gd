extends KinematicBody2D


export var speed: int = 500
var bubble_scene = preload("res://gameplay/bubble/bubble.tscn")


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

	move_and_collide(speed * velocity * delta)


func process_shooting():
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("ui_shoot"):
		var bubble = bubble_scene.instance()
		get_parent().add_child(bubble)
		bubble.global_rotation = global_rotation
		bubble.global_position = $bubble_respawn.global_position
		


func _process(delta):
	process_movement(delta)
	process_shooting()
