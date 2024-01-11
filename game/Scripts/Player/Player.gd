#extends CharacterBody3D
#
#
#const SPEED = 5.0
#const JUMP_VELOCITY = 5
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#
#
#func _physics_process(delta):
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y -= gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
#
	#move_and_slide()
extends CharacterBody3D

#so we can test in inspector
@export var move_speed = 5
@export var jump_height : float = 2
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var jump_velocity : float = (2.0 * jump_height) / jump_time_to_peak 
@onready var jump_gravity : float = (-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
@onready var fall_gravity : float = (-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_descent)

#update and use across framse
var acceleration = 1

func _physics_process(delta):
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		velocity.y += get_gravity() * delta
	#
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		#if player is pressing move button
		print(direction)
		if direction:
			# assign velocity
			print("PRESSING x", velocity.x)
			print("PRESSING z", velocity.z)
			velocity.x = direction.x * move_speed
			velocity.z = direction.z * move_speed
		else:
		#if player is not pressing move button/stopped pressing
		#we use lerp which gradually brings down the velocity
		# lerp(from, to, weight how fast it gets to the next point 0.0-1.0
			print("STOPPED PRESSING x", velocity.x, " ", direction.x * move_speed)
			print("STOPPED PRESSING z", velocity.z, " ", direction.z * move_speed)
			velocity.x = lerp(velocity.x, direction.x , delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z , delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x , delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z , delta * 3.0)
	move_and_slide()
	
func get_gravity():
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func _input(event):
	#only when pressed
	if Input.is_action_pressed("jump") && is_on_floor():
		jump()

func jump():
	velocity.y = jump_velocity
