extends Control


# Allow the user to go back to the home screen upon pressing the Back button on the Credits page.



func _back():
	get_tree().change_scene_to_file("res://start.tscn")
