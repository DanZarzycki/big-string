extends CharacterBody2D

@export var speed = 400

# set keys to move character and set velocity
func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

# movement properties for character
func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)
	MOTION_MODE_FLOATING
