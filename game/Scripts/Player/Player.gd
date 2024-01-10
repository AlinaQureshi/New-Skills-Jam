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
var target_velocity = Vector3.ZERO 

func _physics_process(delta):
	#_physics_process runs 50 times per sec making physics interactions more stable vs _process()
	#move as long as the key/button is pressed
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_backward"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if direction != Vector3.ZERO:
		#normalize the values just in case player presses two buttons simultaneously
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)

	target_velocity.y += get_gravity() * delta
	target_velocity.x = direction.x * move_speed 
	target_velocity.z = direction.z * move_speed 
	# Vertical Velocity
	#if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		#target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	velocity = target_velocity
	#allows smooth character movement
	move_and_slide()

func get_gravity():
	return jump_gravity if velocity.y <0.0 else fall_gravity

func _input(event):
	#only when pressed
	if Input.is_action_pressed("jump") && is_on_floor():
		jump()

func jump():
	target_velocity.y = jump_velocity
