extends Node2D


func bullet_spawned(bullet, position, direction):
	add_child(bullet)
	bullet.add_to_group("bullet")
	bullet.global_position = position
	bullet.set_direction(direction)
	bullet.global_rotation = direction.angle()
