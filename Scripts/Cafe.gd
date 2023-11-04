extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")

@onready var health_area = $HealthArea;
@onready var speed_area = $SpeedArea;
@onready var haste_area = $HasteArea;
@onready var damage_area = $DamageArea;
@onready var cat_area = $CatArea;

var current_shop ="";

var can_pet_cat = false;

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
		_pet_cat();
	pass


	
	#checks the player's current money
func _check_kromer(required_kromer):
	if DungeonManager.kromer < required_kromer: return false;
	else: return true;

func _pet_cat():
	if can_pet_cat == true:
		print("mrow");	
	return;
	
func _buy(shop, price):
	if shop == "Health" and _check_kromer(price):
		DungeonManager.health += 1;
		DungeonManager.kromer -= price
		print("mmm health");
	elif shop == "Speed" and _check_kromer(price):
		DungeonManager.speed += 1;
		DungeonManager.kromer -= price
		print("nyoom");	
	elif shop == "Haste" and _check_kromer(price):
		DungeonManager.haste += 1;
		DungeonManager.kromer -= price
		print("I'm fast as fuck boi");
	elif shop == "Damage" and _check_kromer(price):
		DungeonManager.damage += 1;
		DungeonManager.kromer -= price
		print("Yeouch");	
	elif shop == "":
		print("Not in a shop");
	else:
		print("haha poor");
	return;

func _on_damage_area_body_entered(body):
	if body.is_in_group("player"):
		current_shop = "Damage";
		print("entered damage shop");
	return;


func _on_health_area_body_entered(body):
	if body.is_in_group("player") :
		current_shop = "Health";
		print("entered health shop");
	return;


func _on_speed_area_body_entered(body):
	if body.is_in_group("player"):
		current_shop = "Speed";
		print("entered speed shop");
	return;


func _on_haste_area_body_entered(body):
	if body.is_in_group("player"):
		current_shop = "Haste"	
		print("entered haste shop");
	return;


func _on_health_area_body_exited(body):
	if body.is_in_group("player"):
		print("left health shop")		
		current_shop = "";


func _on_speed_area_body_exited(body):
	if body.is_in_group("player"):
		print("left speed shop")
		current_shop = "";


func _on_haste_area_body_exited(body):
	if body.is_in_group("player"):
		print("left haste shop")
		current_shop = "";


func _on_damage_area_body_exited(body):
	if body.is_in_group("player"):
		print("left damage shop")
		current_shop = "";


func _on_cat_area_body_entered(body):
	if body.is_in_group("player"):
		DungeonManager.CurrentState = DungeonManager.Type.COMBAT
		print("the cat is ready");
		can_pet_cat = true;


func _on_cat_area_body_exited(body):
	if body.is_in_group("player"):
		print("the cat misses you already");
		can_pet_cat = false;

