extends Node

#Get References to Zombie group
var pickup = load("res://Scenes/pickup.tscn")
@onready var ui;


var speed = 200
var max_health = 50
var health = 49
var haste = 60
var damage = 1
var kromer = 0
var Enemies;
var pickup_instance;

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var player = get_tree().get_first_node_in_group("player")
	Enemies = get_tree().get_nodes_in_group("enemy")
	ui = get_tree().get_first_node_in_group("UI");



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ui = get_tree().get_first_node_in_group("UI");
	Enemies = get_tree().get_nodes_in_group("enemy")
	if(Enemies.size()<=0 and get_tree().current_scene.name != "Cafe"):
		get_tree().change_scene_to_file("res://Scenes/Cafe.tscn")				
	ui.get_node("Coins/CoinsLabel").text = str(kromer);	
	return
	
func _chanceDrop(position):
	pickup_instance = pickup.instantiate()
	pickup_instance.position = position
	call_deferred("add_child",pickup_instance)
	#print(pickup_instance.position)
	return
