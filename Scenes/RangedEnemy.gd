extends "res://Scripts/RangedEnemy.gd"

var distance_to_player:Vector2;

@export var Bullet: PackedScene

@onready var gun_end = $GunEnd

var shoot_cooldown = 0;

func _physics_process(delta):
	
	if shoot_cooldown > 0:
		shoot_cooldown-=1;
	match current_state:
		State.PATROL:
			
			pass
		State.ENGAGE:
			#Move away from the player if it's too close
			distance_to_player =  self.position - player.position;
			if distance_to_player.length() < 50:
				move(-distance_to_player, delta);
			
			if shoot_cooldown == 0:
				shoot_cooldown = randf_range(60, 120);
				shoot();
			
			pass

func shoot():
	var bullet_instance = Bullet.instantiate()
	var target = player.position;
	var direction = gun_end.global_position.direction_to(target).normalized()
	BulletManager.bullet_spawned(bullet_instance, gun_end.global_position, direction)
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
	
	
