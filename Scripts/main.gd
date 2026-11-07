extends Node2D

func _process(delta):
	if Input.is_action_pressed("ui_cancel"): # "ui_cancel" maps to Escape by default
		get_tree().quit()
