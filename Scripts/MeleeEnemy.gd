extends "res://Scripts/Enemy.gd"

func _physics_process(delta):
	match current_state:
		State.STUN:
			stun_timer -= delta
			if stun_timer <= 0:
				if player:
					current_state = State.ENGAGE
				else:
					current_state = State.PATROL
		State.PATROL:
			move(current_position.position, delta)
			if global_position.distance_to(current_position.position) < 10:
				get_next_position()
			
		State.ENGAGE:
			move(player.global_position, delta)
