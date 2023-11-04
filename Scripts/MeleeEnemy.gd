extends "res://Scripts/Enemy.gd"

@onready var enemy_anim = $AnimationPlayer
@export var melee_damage = 5
var melee_cooldown = 0.5
var melee_in_range = false

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
	if melee_in_range == true:
		melee_cooldown -= delta
	if melee_cooldown <= 0:
		player.take_damage(melee_damage)
		melee_cooldown = 0.5

func take_damage(dmg):
	enemy_anim.play("take_damage")
	health -= dmg
	current_state = State.STUN
	stun_timer = 0.1
	print(health)
	if health <= 0:
		enemy_anim.play("death1")
		DungeonManager._chanceDrop(global_position)
		queue_free()


func _on_attack_range_body_entered(body):
	if body.is_in_group("player"):
		melee_in_range = true
		print(melee_in_range)
		enemy_anim.play("attack")
		body.take_damage(melee_damage)


func _on_attack_range_body_exited(body):
	if body.is_in_group("player"):
		melee_in_range = false
		print(melee_in_range)
		melee_cooldown = 0.5
	pass # Replace with function body.
