extends KinematicBody2D

export var speed: int = 200
export var velocity: Vector2 = Vector2(1.0, 0.0)
var trapped_enemy = null


func _process(delta):
	var collision = move_and_collide(speed * velocity.rotated(rotation) * delta)
	if collision:
		if collision.collider.is_in_group("enemies") and not trapped_enemy:
			trapped_enemy = collision.collider
			trapped_enemy.get_parent().remove_child(trapped_enemy)
		elif collision.collider.is_in_group("pipes"):
			if trapped_enemy:
				get_parent().add_child(trapped_enemy)
				trapped_enemy.global_position = global_position
			queue_free()
