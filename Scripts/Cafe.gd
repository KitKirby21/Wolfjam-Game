extends Node2D

@onready var player = $Player;
@onready var health_area:Area2D = $HealthArea;
@onready var speed_area = $SpeedArea;
@onready var haste_area = $HasteArea;
@onready var damage_area = $DamageArea;

@export var health_cost = 10;
@export var speed_cost = 10;
@export var haste_cost = 10;
@export var damage_cost = 10;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_check_shop_update();
	pass

func _check_shop_update():
	#checks if the player enters the health area, and if they have enough money buys health
	if health_area.area_entered:
		if _check_kromer(health_cost) == true:
			player.health += 1;
		else: 
			print("haha poor")
			return;
	if speed_area.area_entered:
		if _check_kromer(speed_cost) == true:
			player.speed += 1;
		else: 
			print("haha poor")
			return;
	if haste_area.area_entered:
		if _check_kromer(haste_cost) == true:
			player.health += 1;
		else: 
			print("haha poor")
			return;
	if damage_area.area_entered:
		if _check_kromer(damage_cost) == true:
			player.health += 1;
		else: 
			print("haha poor")
			return;
	
		pass
	pass
	
	#checks the player's current money
func _check_kromer(required_kromer):
	if player.kromer < required_kromer: return false;
	else: return true;
	

