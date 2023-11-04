extends "res://Scripts/Enemy.gd"

@onready var enemy_anim = $AnimationPlayer

func _physics_process(delta):
	match current_state:
		State.STUN:
			stun_process(delta)
		State.PATROL:
			patrol(delta)
			if get_next_position().position > position:
				enemy_anim.play("walk")
			else:
				enemy_anim.play("walk")
		State.ENGAGE:
			move(player.global_position, delta)
			enemy_anim.play("walk")
