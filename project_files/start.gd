extends Control


# Called when the node enters the scene tree for the first time.
func _start():
	get_tree().change_scene_to_file("res://level.tscn")



func _credits():
	get_tree().change_scene_to_file("res://credits.tscn")
