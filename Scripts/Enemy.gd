extends CharacterBody2D

@export var SPEED = 200
var stun_timer = 0
var cat_timer = 0
var health = 5

enum State {
	STUN,
	PATROL,
	ENGAGE
}

@onready var player_detection_zone = $PlayerDetectionZone

@export var marker_group_name : String
var positions : Array
var temp_positions : Array
var current_position : Marker2D
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
	
	positions = get_tree().get_nodes_in_group(marker_group_name)
	get_positions()
	get_next_position()

func _physics_process(delta):
	cat_timer_process(delta)
	match current_state:
		State.STUN:
			stun_process(delta)
		State.PATROL:
			patrol(delta)
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
	current_state = State.STUN
	stun_timer = 0.1
	print(health)
	if health <= 0:
		DungeonManager._chanceDrop(global_position)
		queue_free()

func stun_process(delta):
	stun_timer -= delta
	if stun_timer <= 0:
		if player:
			current_state = State.ENGAGE
		else:
			current_state = State.PATROL
			
func cat_timer_process(delta):
	cat_timer -= delta
	
func get_positions():
	temp_positions = positions.duplicate()
	temp_positions.shuffle()

func get_next_position():
	if temp_positions.is_empty():
		get_positions()
	current_position = temp_positions.pop_front()

func patrol(delta):
	if !marker_group_name:
		return
	move(current_position.position, delta)
	if global_position.distance_to(current_position.position) < 10:
		get_next_position()

func _on_player_detection_zone_body_entered(body):
	if body.is_in_group("player"):
		print("Entered")
		current_state = State.ENGAGE
		player = body


func _on_player_detection_zone_body_exited(body):
	if body.is_in_group("player"):
		#print("Exited")
		current_state = State.PATROL
		player = null

func _on_hitbox_area_entered(area):
	if area.is_in_group("bullet"):
		if area.can_damage_enemies:
			take_damage(area.bullet_damage)
	
	#why the fuck does this never get called when uncommented
	if area.is_in_group("CatAttack"):
		#print("meow")
		#print(area.name)
		if cat_timer == 0:
			cat_timer = randf_range(2,4)
			take_damage(5)
