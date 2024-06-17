extends Node2D

@export var obstacle_scene: PackedScene

var random_obstacle = [load("res://obstacle.tscn"), load("res://obstacle 2.tscn"), load("res://obstacle 3.tscn")]

var obstacle_list

func _ready():
	randomize() # Initialize the random seed
	obstacle_list = get_tree().get_nodes_in_group("obstacle")
	_obstacle()

func _process(delta):
	pass

func _obstacle():
	for item in obstacle_list:
		var random_index = randi_range(0, 2) # Generate a random index between 0 and 2
		var obstacle = random_obstacle[random_index].instantiate()
		obstacle.position = item.global_position
		add_child.call_deferred(obstacle)
