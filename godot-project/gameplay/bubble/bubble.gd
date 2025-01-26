extends KinematicBody2D

export var speed: int = 200
export var velocity: Vector2 = Vector2(1.0, 0.0)
var trapped_enemy = null


func _ready():
	$respawn_sound.play()


func _process(delta):
	var collision = move_and_collide(speed * velocity.rotated(rotation) * delta)
	
	if collision:
		if collision.collider.is_in_group("enemies") and not trapped_enemy:
			# While carrying an enemy, don't collide with other enemies.
			set_collision_mask_bit(2, false)
			trapped_enemy = collision.collider
			trapped_enemy.get_parent().remove_child(trapped_enemy)
			$trapped_alien.visible = true
			print("$buble_sprite/trapped_alien ", $buble_sprite/trapped_alien)
		elif collision.collider.is_in_group("pipes") or collision.collider.is_in_group("pipe_glows"):
			if trapped_enemy:
				if collision.collider.is_in_group("pipes"):
					$trapped_alien.visible = false
					get_parent().add_child(trapped_enemy)
					trapped_enemy.global_position = global_position
				else:
					trapped_enemy.die()
					collision.collider.queue_free()
			queue_free()
