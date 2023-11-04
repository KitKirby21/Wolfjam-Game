extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var manager = $DungeonManager;

@onready var health_area = $HealthArea;
@onready var speed_area = $SpeedArea;
@onready var haste_area = $HasteArea;
@onready var damage_area = $DamageArea;

var current_shop ="";

@export var health_cost = 10;
@export var speed_cost = 10;
@export var haste_cost = 10;
@export var damage_cost = 10;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#_check_shop_update(player);
	if Input.is_action_just_pressed("Interact"):
		_buy(current_shop, 10);	
	pass


	
	#checks the player's current money
func _check_kromer(required_kromer):
	if manager.kromer < required_kromer: return false;
	else: return true;
	
func _buy(shop, price):
	if shop == "Health" and _check_kromer(price):
		manager.health += 1;
		print("mmm health");
	if shop == "Speed" and _check_kromer(price):
		manager.speed += 1;
		print("nyoom");	
	if shop == "Haste" and _check_kromer(price):
		manager.haste += 1;
		print("I'm fast as fuck boi");
	if shop == "Damage" and _check_kromer(price):
		manager.damage += 1;
		print("Yeouch");
	if shop == "":
		print("Not in a shop");
	else:
		print("haha poor");
	return

func _on_damage_area_body_entered(body):
	if body.is_in_group("player"):
		current_shop = "Speed";
	return;


func _on_health_area_body_entered(body):
	if body.is_in_group("player") :
		current_shop = "Health";
	return;


func _on_speed_area_body_entered(body):
	if body.is_in_group("player"):
		current_shop = "Speed";
	return;


func _on_haste_area_body_entered(body):
	if body.is_in_group("player"):
		current_shop = "Haste"	
	return;


func _on_health_area_body_exited(body):
	if body.is_in_group("player"):
		current_shop = "";


func _on_speed_area_body_exited(body):
	if body.is_in_group("player"):
		current_shop = "";


func _on_haste_area_body_exited(body):
	if body.is_in_group("player"):
		current_shop = "";


func _on_damage_area_body_exited(body):
	if body.is_in_group("player"):
		current_shop = "";
