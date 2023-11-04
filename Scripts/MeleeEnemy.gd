extends "res://Scripts/Enemy.gd"

@onready var enemy_anim = $AnimationPlayer

func _physics_process(delta):
	match current_state:
		State.STUN:
			stun_process(delta)
		State.PATROL:
			patrol(delta)
			enemy_anim.play("walk")
		State.ENGAGE:
			move(player.global_position, delta)
			enemy_anim.play("walk")

func take_damage(dmg):
	health -= dmg
	current_state = State.STUN
	stun_timer = 0.1
	print(health)
	if health <= 0:
		DungeonManager._chanceDrop(global_position)
		queue_free()
	enemy_anim.play("take_damage")
