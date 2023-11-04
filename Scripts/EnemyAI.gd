extends Node2D

signal state_changed(new_state)

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
		emit_signal("state_changed", new_state)
var player = null



func _on_player_detection_zone_body_entered(body):
	if body.is_in_group("player"):
		current_state = State.ENGAGE
		player = body


func _on_player_detection_zone_body_exited(body):
	current_state = State.PATROL
	player = null
	pass # Replace with function body.
