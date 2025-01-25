extends KinematicBody2D

export var speed: int = 200
export var velocity: Vector2 = Vector2(1.0, 0.0)

func _process(delta):
	move_and_collide(speed * velocity.rotated(rotation) * delta)
