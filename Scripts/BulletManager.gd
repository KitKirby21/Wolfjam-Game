extends Node2D


func bullet_spawned(bullet, position, direction, enemy_damage):
	add_child(bullet)
	bullet.global_position = position
	bullet.set_direction(direction)
	bullet.global_rotation = direction.angle()
	bullet.can_damage_enemies = enemy_damage;
