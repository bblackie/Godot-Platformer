extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(400.0, 500.0) # set a max speed
export var gravity: = 3500.0 # export makes the variable configuratble

var _velocity: = Vector2.ZERO


# handles collisions and movement 
# delta makes the movement constant irrespetive of computer speed
func _physics_process(delta: float) -> void:
	_velocity.y += 	gravity * delta
	
	
	# limit velocity
	#velocity.y = max(velocity.y, speed.y)
	#velocity = move_and_slide(velocity) # handles collisions, hence the velocity outputted
	
