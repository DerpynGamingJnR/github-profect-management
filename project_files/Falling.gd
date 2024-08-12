extends Area2D
var falling = false

# Called when the node enters the scene tree for the first time.
func _falling_obstacle(area):
		falling = true

func _process(delta):
	if falling:
		position.y += 10
