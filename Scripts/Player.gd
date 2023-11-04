extends CharacterBody2D

@export var speed = 200

@export var can_move = true

@onready var anim_player = $Sprite2D/AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _get_input():
	var input_direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	velocity = input_direction * speed
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	print("bang")

func _physics_process(delta):
	_get_input()
	move_and_slide()
