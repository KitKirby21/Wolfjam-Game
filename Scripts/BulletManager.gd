extends Node2D

@export var bullets = []

func bullet_spawned(bullet, position, direction):
	add_child(bullet)
	bullet.global_position = position
	bullet.set_direction(direction)
	bullet.global_rotation = direction.angle()
	bullets.push_back(bullet)
