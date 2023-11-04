extends "res://Scripts/Enemy.gd"

func _physics_process(delta):
	match current_state:
		State.PATROL:
			move(current_position.position, delta)
			if global_position.distance_to(current_position.position) < 10:
				get_next_position()
			
		State.ENGAGE:
			move(player.global_position, delta)
