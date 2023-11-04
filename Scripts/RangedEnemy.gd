extends "res://Scripts/Enemy.gd"

var distance_to_player:Vector2;

signal shot(bullet, position, direction)

@export var Bullet: PackedScene

@onready var gun_end = $"Gun End"

var shoot_cooldown = 0;

func _physics_process(delta):
	
	if shoot_cooldown > 0:
		shoot_cooldown-=1;
	match current_state:
		State.STUN:
			stun_process(delta);
		State.PATROL:
			patrol(delta);
		State.ENGAGE:
			#Move away from the player if it's too close
			distance_to_player =  self.position - player.position;
			if distance_to_player.length() < 500:
				move(-distance_to_player, delta);
				get_next_position();
			
			if shoot_cooldown == 0:
				shoot();
				shoot_cooldown = randi_range(60, 120);
			pass

func shoot():
	var bullet_instance = Bullet.instantiate()
	var target = player.position;
	var direction = gun_end.global_position.direction_to(target).normalized()
	BulletManager.bullet_spawned(bullet_instance, gun_end.global_position, direction, false)
#func _wander(radius, delta):
#	var distance = randf_range(0, radius);
#	var target:Vector2;
#
#	target.x = randf_range(0, distance);
#	target.y = randf_range(0, distance);
#
#	if target.x > get_screen_transform().x or target.x < 0:
#		target.x = randf_range(0, distance);
#	if target.y > get_screen_transform().y or target.y < 0:
#		target.y = randf_range(0, distance);
#
#	move(target, delta);
	
	
