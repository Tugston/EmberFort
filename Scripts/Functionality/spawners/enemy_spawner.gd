extends Node

var enemy_scene = preload("res://Entities/Enemy/Slimes/green_slime/green_slime.tscn")

@export var spawn_delay: float = 6.0
@export var spawn_points: Array[Vector2]

@onready var tower: BaseStructure = %HomeTower

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = spawn_delay
	timer.one_shot = false
	timer.timeout.connect(spawn_enemy)
	timer.start()
	spawn_enemy()
	return

func spawn_enemy() -> void:
	var enemy = enemy_scene.instantiate()
	enemy.position = grab_random_spawn()
	enemy.game_state = %GameState
	#print(enemy.position)
	enemy.target_tower = tower
	add_child(enemy)
	return
	
func grab_random_spawn() -> Vector2:
	var initial_index: int = randi() % spawn_points.size() - 1
	var random_position: Vector2 = Vector2.ZERO
	if initial_index <= spawn_points.size() - 1:
		var first_position: Vector2 = spawn_points[initial_index]
		var second_position: Vector2 = spawn_points[initial_index + 1]
		random_position.x = randf_range(first_position.x, second_position.x)
		random_position.y = randf_range(first_position.y, second_position.y)
	else: #initial index should always be equal to the exact size
		var first_position: Vector2 = spawn_points[initial_index]
		var second_position: Vector2 = spawn_points[0]
		random_position.x = randf_range(first_position.x, second_position.x)
		random_position.y = randf_range(first_position.y, second_position.y)
	return random_position
