extends CharacterBody2D

signal shot(bullet, position, direction)


@export var can_move = true

@export var Bullet: PackedScene

@onready var anim_player = $Sprite2D/AnimationPlayer

@onready var gun_end = $GunEnd

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
		print(self.position)
		anim_player.play("Swing")

func shoot():
	var bullet_instance = Bullet.instantiate()
	var target = get_global_mouse_position()
	var direction = gun_end.global_position.direction_to(target).normalized()
	BulletManager.bullet_spawned(bullet_instance, gun_end.global_position, direction, true)

func _physics_process(delta):
	_get_input()
	move_and_slide()

#melee hit detection
func _on_melee_swing_area_entered(area):
	if area.is_in_group("enemy"):
		#area.take_damage(damage)
		get_tree().call_group("enemy", "take_damage")
		print("took damage")
		#if area.has_method("take_damage"):
			#area.take_damage(damage)
			#print("hit")
	else:
		print("cannot take damage")
