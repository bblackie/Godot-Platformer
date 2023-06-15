extends "res://src/Actors/Actor.gd"


# enemy always starts moving left because actor always starts moving right
func _ready() -> void:
	# stop movement if outside of screen
	set_physics_process(false)
	# start going left
	_velocity.x = -speed.x 

# callbacks come after the ready function by convention
func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	# make the enemy die
	# compare stomp detector and player to confirm stomp
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	# ensure lag in deleting the enemy allow a collision
	get_node("CollisionShape2D").disable = true
	# delete enemy
	queue_free() 

# enemy will change direction when it touches the wall, i.e. reverse speed
# moves at constant speed
# can use velocity from Player parent object
func _physics_process(delta: float) -> void:
	
	# add gravity
	_velocity.y += gravity * delta
	
	# bounce off walls
	if is_on_wall():
		_velocity.x *= -1.0
		
	# recalculate speed
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	






