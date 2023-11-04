extends "res://Scripts/Enemy.gd"

func _physics_process(delta):
	match current_state:
		State.PATROL:
			pass
		State.ENGAGE:
			move(player.global_position, delta)
