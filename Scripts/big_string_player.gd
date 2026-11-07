extends CharacterBody2D

@export var speed = 350
const up_speed = 500
const down_speed = 200
const side_speed = 350
var bounds = get_viewport_rect().size

# set keys to move character and set velocity
func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

# movement properties for character
func _physics_process(delta):
	get_input()
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity.x = direction.x * side_speed
	velocity.y = direction.y * (up_speed if direction.y < 0 else down_speed)
	
	move_and_collide(velocity * delta)
	MOTION_MODE_FLOATING
	
	### Work on this next time, to streamline code
	#var out_of_bounds = position.clamp(Vector2.ZERO, bounds)
	#if out_of_bounds.x != position.x:
	#	velocity.x = 0
	#if out_of_bounds.y != position.y:
	#	velocity.x = 0
	#position = out_of_bounds
	
	# stop upward momentum at the ceiling
	if position.y < bounds.y:
		position.y = 0
		velocity.y = 0
	elif position.y > 1280:
		position.y = 1280
		velocity.y = 0

	#stop leftward momentum on wall
	if position.x < bounds.x:
		position.x = 0
		velocity.x = 0

	#stop rightward momentum on wall
	if position.x > 720:
		position.x = 720
		velocity.x = 0
