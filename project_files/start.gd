extends Control


# When pressed, the buttons will redirect the user to scene corresponding to that button (Play lead to the game, Credits lead to the Credits page)
func _start():
	get_tree().change_scene_to_file("res://level.tscn")

func _credits():
	get_tree().change_scene_to_file("res://credits.tscn")
