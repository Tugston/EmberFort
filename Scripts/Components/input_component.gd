class_name InputComponent extends Node

var move_direction: Vector2 = Vector2.ZERO

signal action_interact

func _ready() -> void:
	set_physics_process(false)
	return

func update() -> Vector2i:
	var input_dir: Vector2i = Vector2i.ZERO
	if Input.is_action_just_pressed("move_up"):
		input_dir.y -= 1
	elif Input.is_action_just_pressed("move_down"):
		input_dir.y += 1
	elif Input.is_action_just_pressed("move_left"):
		input_dir.x -= 1
	elif Input.is_action_just_pressed("move_right"):
		input_dir.x += 1
	
	if Input.is_action_just_pressed("interact"):
		action_interact.emit()
	
	return input_dir
