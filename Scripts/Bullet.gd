extends Area2D


@export var bullet_speed: int = 20

var direction :=Vector2.ZERO



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * bullet_speed
		global_position += velocity

func set_direction(direction: Vector2):
	self.direction = direction;
