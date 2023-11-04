extends Control

@onready var anim = $CanvasLayer/Cat/Sprite2D/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("cat_idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_respawn_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Cafe.tscn")


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/TitleScreen.tscn")


func _on_quit_button_pressed():
	get_tree().quit()

#play meow
func _on_cat_pressed():
	pass # Replace with function body.
