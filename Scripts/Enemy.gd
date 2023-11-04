extends CharacterBody2D

@export var SPEED = 200

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

func _ready():
	add_to_group("enemy")

func _physics_process(delta):
	match current_state:
		State.PATROL:
			pass
		State.ENGAGE:
			move(player.global_position, delta)

func move(target, delta):
	var direction = (target - global_position).normalized()
	var desired_velocity = direction * SPEED
	var steering = (desired_velocity - velocity) * delta * 2.5
	velocity += steering
	move_and_slide()

func take_damage(dmg):
	health -= dmg
	print(health)
	if health <= 0:
		DungeonManager._chanceDrop(global_position)
		queue_free()

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

func _on_hitbox_area_entered(area):
	if area.is_in_group("bullet"):
		health -= area.bullet_damage
		print(health)
		if health <= 0:
			#print(self.position)
			DungeonManager._chanceDrop(self.position)
			queue_free()
		take_damage(area.bullet_damage)
