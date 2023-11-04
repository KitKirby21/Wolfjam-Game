extends Area2D
var healthPickup;

# Called when the node enters the scene tree for the first time.
func _ready():
	if(DungeonManager.health<=50):
		$AnimatedSprite2D.frame = 1
		healthPickup = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if (body.is_in_group("player")):
		if(healthPickup):
			DungeonManager.health+=15
		else:
			DungeonManager.kromer+=5
		queue_free()
		
		
