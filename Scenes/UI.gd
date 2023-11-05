extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Coins/CoinsLabel.text = str(DungeonManager.kromer);
	$Health/HealthBar.max_value = DungeonManager.max_health;
	$Health/HealthBar.value = DungeonManager.health;
