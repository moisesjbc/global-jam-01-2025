extends KinematicBody2D


export var speed: int = 200
var target


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity: Vector2 = (target.global_position - global_position).normalized()
	
	var collision = move_and_collide(speed * velocity * delta)
	$sprite.flip_h = velocity.x < 0
	if collision and collision.collider.name == "player":
		collision.collider.die()
