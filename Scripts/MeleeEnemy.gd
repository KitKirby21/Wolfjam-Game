extends "res://Scripts/Enemy.gd"

@export var marker_group_name : String
var positions : Array
var temp_positions : Array
var current_position : Marker2D

func _ready():
	add_to_group("enemy")
	DungeonManager._chanceDrop(self.position)
	
	positions = get_tree().get_nodes_in_group(marker_group_name)
	get_positions()
	get_next_position()

func _physics_process(delta):
	match current_state:
		State.PATROL:
			move(current_position.position, delta)
			if global_position.distance_to(current_position.position) < 10:
				get_next_position()
			
		State.ENGAGE:
			move(player.global_position, delta)

func get_positions():
	temp_positions = positions.duplicate()
	temp_positions.shuffle()

func get_next_position():
	if temp_positions.is_empty():
		get_positions()
	current_position = temp_positions.pop_front()
