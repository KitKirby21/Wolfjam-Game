extends Node

#Get References to Zombie group
var pickup = load("res://Scenes/pickup.tscn")

var DungeonSquare = load("res://Scenes/Main.tscn")
var DungeonTShape = load("res://Scenes/DungeonLayouts/DungeonTShape.tscn")
var DungeonConnector = load("res://Scenes/DungeonLayouts/DungeonConnector.tscn")
var DungeonLeft = load("res://Scenes/DungeonLayouts/DungeonLeft.tscn")

var Levels = [DungeonSquare,DungeonTShape,DungeonConnector,DungeonLeft]

var speed = 200
var max_health = 50
var health = 49
var haste = 60
var damage = 1
var kromer = 0
var Enemies;
var pickup_instance;

var LevelsCompleted = 0;
var CurrentState;

enum Type {
	COMBAT,
	CAFE
}

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_tree().get_first_node_in_group("player")
	Enemies = get_tree().get_nodes_in_group("enemy")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Enemies = get_tree().get_nodes_in_group("enemy")
	if(DungeonManager.CurrentState==DungeonManager.Type.COMBAT):
		get_tree().change_scene_to_packed(Levels[0])
		
	if(Enemies.size()<=0 && Type.COMBAT):
		#get_tree().change_scene_to_file("res://Scenes/Cafe.tscn")
		return
	
func _chanceDrop(position):
	pickup_instance = pickup.instantiate()
	pickup_instance.position = position
	call_deferred("add_child",pickup_instance)
	#print(pickup_instance.position)
	return
