extends "res://Scripts/RangedEnemy.gd"

func _physics_process(delta):
	match current_state:
		State.PATROL:
			pass
		State.ENGAGE:
			pass
