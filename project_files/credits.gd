extends Control


# Called when the node enters the scene tree for the first time.



func _back():
	get_tree().change_scene_to_file("res://start.tscn")
