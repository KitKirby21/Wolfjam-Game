extends Node2D

func change_scene(target: String) -> void:
	$AnimationPlayer.play('Dissolve')
	await($AnimationPlayer)
	get_tree().change_scene(target)
	$AnimationPlayer.play_backwards('Dissolve')
