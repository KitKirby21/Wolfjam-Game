extends "res://Scripts/Enemy.gd"

func _physics_process(delta):
	match current_state:
		State.STUN:
			stun_process(delta)
		State.PATROL:
			patrol(delta)
		State.ENGAGE:
			move(player.global_position, delta)
