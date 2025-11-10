extends CharacterBody2D

const GRAVITY : int = 1000
const MAX_VEL : int = 600
const CLIMB_SPEED : int = -400
var climbing : bool = false
var falling : bool = false
const START_POS = Vector2(100, 400)

# Called when node enters the scene tree for the first time
func _ready():
	reset()


func reset():
	falling = false
	climbing = false
	position = START_POS

# Called every frame. 'delta' is the elapsed time since the previous frame
func _physics_process(delta):
	if climbing or falling:
		velocity.y += GRAVITY * delta
		#terminal velocity
		if velocity.y > MAX_VEL:
			velocity.y = MAX_VEL
		move_and_collide(velocity * delta)

func climb():
	velocity.y = CLIMB_SPEED


func _on_ground_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
