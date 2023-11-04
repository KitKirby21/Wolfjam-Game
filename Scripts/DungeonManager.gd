extends Node2D

#Get References to Zombie group
var pickup = load("res://Scenes/pickup.tscn")
@onready var ui;


var DungeonSquare = load("res://Scenes/Main.tscn")
var DungeonTShape = load("res://Scenes/DungeonLayouts/DungeonTShape.tscn")
var DungeonConnector = load("res://Scenes/DungeonLayouts/DungeonConnector.tscn")
var DungeonLeft = load("res://Scenes/DungeonLayouts/DungeonLeft.tscn")

var Levels = ["DungeonLayouts/DungeonTShape","DungeonLayouts/DungeonConnector","DungeonLayouts/DungeonLeft","DungeonLayouts/DungeonSquare"]
var levelNum = 0
var speed = 200
var max_health = 50
var health = 49
var haste = 60
var damage = 1
var kromer = 0
var Enemies;
var pickup_instance;


#Scene Stuff
var scene_to_load


var level_instance;

var LevelsCompleted = 0;
var CurrentState;

enum Type {
	COMBAT,
	MAINMENU
}


# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_tree().get_first_node_in_group("player")
	Enemies = get_tree().get_nodes_in_group("enemy")
	ui = get_tree().get_first_node_in_group("UI");
	print(ui)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ui = get_tree().get_first_node_in_group("UI");
	Enemies = get_tree().get_nodes_in_group("enemy")
	if(ui):	
		ui.get_node("Coins/CoinsLabel").text = str(kromer);
		ui.get_node("Health/HealthBar").max_value = max_health;
		ui.get_node("Health/HealthBar").value = health;

	#print(CurrentState)
	if(Enemies.size()<=0 &&CurrentState==Type.COMBAT):
		if(levelNum>=4):
			load_level("Menus/EndScreen")
			return
		var levelpath = Levels[levelNum]
		for pickup in get_tree().get_nodes_in_group("pickup"):
			pickup.visible=false
		load_level(levelpath)
		levelNum+=1
	

func unload_level():
	if(is_instance_valid(level_instance)):
		level_instance.queue_free()
		level_instance = null

func load_level(level_name : String):
	unload_level()
	var level_path = "res://Scenes/%s.tscn" % level_name
	print(level_path)
	scene_to_load = load(level_path)
	level_instance = scene_to_load.instantiate()
	#levels.add_child(level_instance)
	get_tree().change_scene_to_packed(scene_to_load)
	
func _chanceDrop(position):
	pickup_instance = pickup.instantiate()
	pickup_instance.position = position
	call_deferred("add_child",pickup_instance)
	#print(pickup_instance.position)
	return
