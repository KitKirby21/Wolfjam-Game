extends Node

#Get References to Zombie group


#

# Called when the node enters the scene tree for the first time.
func _ready():
	var Enemies = get_tree().get_nodes_in_group("Enemies")
	var player = get_tree().get_first_node_in_group("player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	return
func _chanceDrop(position):
	print(position)
	return
