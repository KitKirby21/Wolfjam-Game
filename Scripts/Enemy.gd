extends CharacterBody2D

var speed = 200
var motion = Vector2.ZERO
var player = null

func _physics_process(delta):
	if player:
		motion = position.direction_to(player.position) * speed
	velocity = motion;
	move_and_slide()



func _on_area_2d_body_entered(body):
	player = body


func _on_area_2d_body_exited(body):
	player = null
