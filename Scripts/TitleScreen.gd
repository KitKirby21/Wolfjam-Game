extends Control

@onready var cat_anim = $CanvasLayer/Cat/Sprite2D/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	cat_anim.play("cat_idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	DungeonManager.load_level("DungeonLayouts/DungeonSquare")
	DungeonManager.CurrentState = DungeonManager.Type.COMBAT
	#var scene = load("res://Scenes/DungeonLayouts/DungeonSquare.tscn")
	#var instance = scene.instantiate()
	#get_tree().addchild(instance)
	#get_tree().change_scene_to_file("res://Scenes/Cafe.tscn")

	


func _on_controls_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/OptionsScreen.tscn")


func _on_quit_button_pressed():
	get_tree().quit()

#play meow here
func _on_cat_pressed():
	pass # Replace with function body.
