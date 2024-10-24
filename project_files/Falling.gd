extends Area2D
var falling = false

# Change the falling to true and let the falling obstacle fall onto the player and kill them when they fail to jump over the red X indicator.
func _falling_obstacle(area):
		falling = true

func _process(delta):
	if falling:
		position.y += 10
