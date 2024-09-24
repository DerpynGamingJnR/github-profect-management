extends CharacterBody2D


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

func _ready():
	total_distance = end.global_position.x - global_position.x

func _physics_process(delta):
	remaining_distance = end.global_position.x - global_position.x
	covered_distance = total_distance - remaining_distance
	if covered_distance / total_distance < 1.0:
		get_node("/root/Node2D/CharacterBody2D/Camera2D/Path2D/PathFollow2D").progress_ratio = covered_distance / total_distance
		get_node("/root/Node2D/CharacterBody2D/Camera2D/Path2D/PathFollow2D/AnimatedSprite2D").play("Head")
	else:
		get_node("/root/Node2D/CharacterBody2D/Camera2D/Path2D/PathFollow2D/AnimatedSprite2D").play("Normal")
		
	if not in_cutscene:
	# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
			$AnimatedSprite2D.play("jump")
		else:
			$AnimatedSprite2D.play("walk")

		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
	#	var direction = Input.get_axis("ui_left", "ui_right")
	#	if direction:
	#		velocity.x = direction * SPEED
	#	else:
	#		velocity.x = move_toward(velocity.x, 0, SPEED)

		velocity.x = SPEED

		move_and_slide()
	else:
		velocity.x = 0
		$AnimatedSprite2D.play(animation)
	
func _obstacle():
	var obstacle = obstacle_scene.instantiate()
	obstacle.position = $ObstacleSpawn.global_position
	add_sibling(obstacle)

#func _death(area):
#	if area.has_meta("obstacle"):
#		get_tree().reload_current_scene()

func _end_cutscene(area):
	if area.has_meta("end_cutscene"):
		in_cutscene = true
		get_node("/root/Node2D/AudioStreamPlayer").playing = false
		get_node("/root/Node2D/AnimationPlayer").play("end_cutscene")



