extends CharacterBody2D

signal shot(bullet, position, direction)

@export var speed = 200

@export var health = 50

@export var haste = 60

@export var damage = 1

@export var kromer = 0

@export var can_move = true

@export var Bullet: PackedScene

@onready var anim_player = $Sprite2D/AnimationPlayer

@onready var gun_end = $GunEnd

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#gets player input
func _get_input():
	var input_direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	velocity = input_direction * speed
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"):
		shoot()

#perform ranged attack
func shoot():
	var bullet_instance = Bullet.instantiate()
	var target = get_global_mouse_position()
	var direction = gun_end.global_position.direction_to(target).normalized()
	BulletManager.bullet_spawned(bullet_instance, gun_end.global_position, direction)

#get input and move things accordingly
func _physics_process(delta):
	_get_input()
	move_and_slide()

#perform melee attack
func _on_melee_swing_area_entered(area):
	pass # Replace with function body.
