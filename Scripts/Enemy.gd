extends CharacterBody2D

@export var SPEED = 100

var health = 5

enum State {
	PATROL,
	ENGAGE
}

@onready var player_detection_zone = $PlayerDetectionZone

var current_state:int = State.PATROL:
	get:
		return current_state
	set(new_state):
		if new_state == current_state:
			return
		current_state = new_state
var player = null

func _physics_process(delta):
	match current_state:
		State.PATROL:
			pass
		State.ENGAGE:
			var direction = (player.global_position - global_position).normalized()
			var desired_velocity = direction * SPEED
			var steering = (desired_velocity - velocity) * delta * 2.5
			velocity += steering
			move_and_slide()


func _on_player_detection_zone_body_entered(body):
	if body.is_in_group("player"):
		print("Entered")
		current_state = State.ENGAGE
		player = body


func _on_player_detection_zone_body_exited(body):
	if body.is_in_group("player"):
		print("Exited")
		current_state = State.PATROL
		player = null


func _on_hitbox_body_entered(body):
	if body.is_in_group("bullet"):
		health -= body.damage
