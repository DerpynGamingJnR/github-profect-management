extends CharacterBody2D

# Setting all the variables used that are to be run in the game as it read down the code.
@export var SPEED = 350.0
@export var JUMP_VELOCITY = -350.0
@export var obstacle_scene: PackedScene
@export var animation = ""
@onready var end = get_node("/root/Node2D/Area2D")
var in_cutscene = false
var falling = false
var total_distance
var remaining_distance
var covered_distance

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Calculate the total distance the player have to travel before reaching the end of the game.
func _ready():
	total_distance = end.global_position.x - global_position.x

# Calculate the remaining distance that the player have to travel before reaching the end and the distance covered already by the player as they play.
func _physics_process(delta):
	remaining_distance = end.global_position.x - global_position.x
	covered_distance = total_distance - remaining_distance
	if covered_distance / total_distance < 1.0:
		get_node("/root/Node2D/CharacterBody2D/Camera2D/Path2D/PathFollow2D").progress_ratio = covered_distance / total_distance
		get_node("/root/Node2D/CharacterBody2D/Camera2D/Path2D/PathFollow2D/AnimatedSprite2D").play("Head")
	else:
		get_node("/root/Node2D/CharacterBody2D/Camera2D/Path2D/PathFollow2D/AnimatedSprite2D").play("Normal")
# If the above is less than the total distance, the indicator-like map animation will play. If not, the animation stop and it stop once reaching the end.

	if not in_cutscene:
	# When the player hasn't reach the end of the game, the player will move to the right without the user having any control over and play the walk animation
		if not is_on_floor():
			velocity.y += gravity * delta
			$AnimatedSprite2D.play("jump")
		else:
			$AnimatedSprite2D.play("walk")

		# Handle Jump and play the jump animation if the player is not on the floor of the game.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		velocity.x = SPEED

		move_and_slide()
	else:
		velocity.x = 0
		$AnimatedSprite2D.play(animation)

# Manage the spawning of obstacles throughout the game by spawning them where the spawners are placed.
func _obstacle():
	var obstacle = obstacle_scene.instantiate()
	obstacle.position = $ObstacleSpawn.global_position
	add_sibling(obstacle)

# Manage the death of the user if they fail to jump over the obstacles or get hit by falling osbtacles, reset them back to the start every time.
func _death(area):
	if area.has_meta("obstacle"):
		get_tree().reload_current_scene()

# Manage the end of the game for when the player reaches it, stop everything else running during the game and play the end cutscene animation.
func _end_cutscene(area):
	if area.has_meta("end_cutscene"):
		in_cutscene = true
		get_node("/root/Node2D/AudioStreamPlayer").playing = false
		get_node("/root/Node2D/AnimationPlayer").play("end_cutscene")



