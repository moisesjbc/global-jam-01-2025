extends KinematicBody2D


export var speed: int = 500
var bubble_scene = preload("res://gameplay/bubble/bubble.tscn")
var n_bubbles = 1
signal player_died
var lateral_animation_threshold = 150
onready var current_buble_respawn = $buble_respawns/right


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
	current_buble_respawn.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("ui_shoot") and n_bubbles > 0:
		n_bubbles -= 1
		var bubble = bubble_scene.instance()
		get_parent().add_child(bubble)
		bubble.global_rotation = current_buble_respawn.global_rotation
		bubble.global_position = current_buble_respawn.global_position
		

func process_animation():
	if get_local_mouse_position().y < lateral_animation_threshold and get_local_mouse_position().y > -lateral_animation_threshold:
		if $sprite.animation != "lateral_idle":
			$sprite.play("lateral_idle")
		if get_local_mouse_position().x < 0:
			current_buble_respawn = $buble_respawns/left
			$sprite.flip_h = true
		else:
			current_buble_respawn = $buble_respawns/right
			$sprite.flip_h = false
	else:
		if get_local_mouse_position().y > lateral_animation_threshold:
			current_buble_respawn = $buble_respawns/down
			if $sprite.animation != "down_idle":
				$sprite.play("down_idle")
		elif get_local_mouse_position().y < -lateral_animation_threshold:
			current_buble_respawn = $buble_respawns/up
			if $sprite.animation != "up_idle":
				$sprite.play("up_idle")


func recharge_bubbles():
	n_bubbles = 1


func _process(delta):
	process_movement(delta)
	process_animation()
	process_shooting()


func die():
	emit_signal("player_died")
