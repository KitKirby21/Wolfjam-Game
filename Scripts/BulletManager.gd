extends Node2D


func bullet_spawned(bullet, position, direction):
	add_child(bullet)
	bullet.global_position = position
	bullet.set_direction(direction)
	bullet.z_index = 3
	bullet.global_rotation = direction.angle()
