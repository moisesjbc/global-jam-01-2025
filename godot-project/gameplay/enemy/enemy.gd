extends KinematicBody2D


export var speed: int = 200
var target


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity: Vector2 = Vector2(1.0, 0.0)
	look_at(target.global_position)

	var collision = move_and_collide(speed * velocity.rotated(rotation) * delta)
	if collision and collision.collider.name == "player":
		collision.collider.die()
