extends Actor

export var stomp_impulse: = 1000.0 # pixels per second

# callbacks after ready 
func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	# calculate stomp velocity
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	# kill the player
	queue_free()


# Handling the movement of the player according to keys pressed
func _physics_process(delta: float) -> void:
	
	# If velocity is up, i.e. jumping, and it's interrupted, i.e. if key is released, change velocity
	# This allows us to moderate the high of the jump based on how long the key is pressed
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	# all mutatations to velocity happen here
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
# Separate out direction for usability
func get_direction() -> Vector2:
	# x axis: -1.0 to 1.0 left to right
	# y axis: -1.0 to jump, 1.0 to fall
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

	
func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
		
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += 	gravity * get_physics_process_delta_time()
	# on jump
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	return out

# to create the bounce after the stomp, simply replace the y value with the stomp impulse
func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse 
	return out

# CONVENTIONS
# underscore in _velocity indicates it is private

# SHORTCUTS
# Keys
# To rename a variable in file >> double-click variable > press CTRL-R (for replace) and change name
# To rename a variable across the project >> double-click variable > press CTRL-SHFT-F (for replace) and change name
 






