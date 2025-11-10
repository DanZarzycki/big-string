extends Node2D

@export var stals_scene : PackedScene

var game_running : bool
var game_over : bool
var scroll
var score
const SCROLL_SPEED : int = 3
var screen_size : Vector2i
var ground_height : int
var stals : Array
const STAL_DELAY : int = 100
const STAL_RANGE : int = 200


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size
	new_game()

func generate_stals():
	var stal_place = stals_scene.instantiate()
	stal_place.position.x = screen_size.x + STAL_DELAY
	# This was the original: stal_place.position.y = screen_size.y / 2 + randi_range(-STAL_RANGE, STAL_RANGE)
	stal_place.position.y = screen_size.y / 3 + randi_range(-STAL_RANGE, STAL_RANGE)
	stal_place.hit.connect(string_hit)
	add_child(stal_place)
	stals.append(stal_place)

func new_game():
	#reset variables
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	stals.clear()
	#generate starting stals
	generate_stals()
	$BigString.reset()

func _input(event):
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $BigString.climbing:
						$BigString.climb()

func start_game():
	game_running = true
	$BigString.climbing = true
	$BigString.climb()
	$StalTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if game_running:
		scroll += SCROLL_SPEED
		if scroll >= screen_size.x:
			scroll = 0
		for stals in stals:
			stals.position.x -= SCROLL_SPEED

func _on_stal_timer_timeout() -> void:
	generate_stals()

func string_hit():
	pass #come back to this
