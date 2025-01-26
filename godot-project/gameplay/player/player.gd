extends KinematicBody2D


export var min_speed = 400
export var speed: float = min_speed
export var max_speed = 500
export var speed_step = 50
var bubble_scene = preload("res://gameplay/bubble/bubble.tscn")
var n_bubbles = 1
signal player_died
var lateral_animation_threshold = 150
onready var current_buble_respawn = $buble_respawns/right
var moving: bool = false
signal gun_emptied
signal gun_reloaded


func process_movement(delta):
	var new_moving = false
	var velocity: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		new_moving = true
		velocity.x = -1
	elif Input.is_action_pressed("ui_right"):
		new_moving = true
		velocity.x = 1

	if Input.is_action_pressed("ui_up"):
		new_moving = true
		velocity.y = -1
	elif Input.is_action_pressed("ui_down"):
		new_moving = true
		velocity.y = 1
		
	if not moving and new_moving:
		speed = min_speed

	if new_moving:
		print("max_speed ", max_speed)
		print("new speed ", speed + speed_step * delta)
		
		speed = min(max_speed, speed + speed_step * delta)
		print("speed ", speed)

	var collision = move_and_collide(speed * velocity * delta)
	if collision and (collision.collider.name == "font"):
		recharge_bubbles()


	moving = new_moving

func process_shooting():
	current_buble_respawn.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("ui_shoot") and n_bubbles > 0:
		emit_signal("gun_emptied")
		n_bubbles -= 1
		var bubble = bubble_scene.instance()
		get_parent().add_child(bubble)
		bubble.global_rotation = current_buble_respawn.global_rotation
		bubble.global_position = current_buble_respawn.global_position
		

func process_animation():
	if not moving:
		if $sprite.animation != "lateral_idle":
			$sprite.play("lateral_idle")
	else:
		if $sprite.animation != "walking":
			$sprite.play("walking")
	
	if get_local_mouse_position().x < 0:
		current_buble_respawn = $buble_respawns/left
		$sprite.flip_h = true
	else:
		current_buble_respawn = $buble_respawns/right
		$sprite.flip_h = false


func recharge_bubbles():
	if n_bubbles < 1:
		n_bubbles = 1
		emit_signal("gun_reloaded")


func _process(delta):
	process_movement(delta)
	process_animation()
	process_shooting()


func die():
	emit_signal("player_died")
