extends KinematicBody2D

export var initial_speed: int = 120
export var speed: int = 0
var target
signal enemy_died


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity: Vector2 = (target.global_position - global_position).normalized()
	
	var collision = move_and_collide(speed * velocity * delta)
	$sprite.flip_h = velocity.x < 0
	if collision and collision.collider.name == "player":
		collision.collider.die()


func die():
	emit_signal("enemy_died")



func _on_sprite_animation_finished():
	speed = initial_speed
	$sprite.play("walking")
