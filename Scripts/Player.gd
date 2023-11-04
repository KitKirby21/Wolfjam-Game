extends CharacterBody2D

signal shot(bullet, position, direction)

var cat_timer = 0

@export var can_move = true

@export var Bullet: PackedScene

@onready var anim_player = $Sprite2D/AnimationPlayer

@onready var cat_anim_player = $CatAttackSprite/CatAttackAnim

@onready var gun_end = $GunEnd

@onready var catAttack = $CatAttackSprite/CatAttack/CollisionShape2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _get_input():
	var input_direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	velocity = input_direction * DungeonManager.speed
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"):
		shoot()
	if Input.is_action_just_pressed("swing"):
		#print(self.position)
		anim_player.play("swing")

func shoot():
	var bullet_instance = Bullet.instantiate()
	var target = get_global_mouse_position()
	var direction = gun_end.global_position.direction_to(target).normalized()
	BulletManager.bullet_spawned(bullet_instance, gun_end.global_position, direction, true)
	anim_player.play("shoot")

func _physics_process(delta):
	_get_input()
	move_and_slide()
	cat_timer_process(delta)

func cat_timer_process(delta):
	print(cat_timer)
	cat_timer -= delta

func take_damage(dmg):
	DungeonManager.health -= dmg
	anim_player.play("take_damage")
	if DungeonManager.health <= 0:
		DungeonManager.health = 0
		DungeonManager.load_level("Menus/DeathScreen")


func _on_hitbox_area_entered(area):
	if area.is_in_group("bullet"):
		if area.can_damage_enemies == false:
			take_damage(area.bullet_damage)
			area.queue_free()


func _on_melee_swing_body_entered(body):
	if body.is_in_group("enemy"):
		body.take_damage(DungeonManager.damage)
		#get_tree().call_group("enemy", "take_damage")
		#print("took damage")
		#if area.has_method("take_damage"):
			#area.take_damage(damage)
			#print("hit")
			
func cat_attack(catAttack):
	if catAttack.is_in_group("enemy"):
		if cat_timer <= 0:
			cat_timer = 2
			catAttack.take_damage(5)
			cat_anim_player.play("cat_slap")
	else:
		cat_anim_player.play_backwards("cat_slap")
