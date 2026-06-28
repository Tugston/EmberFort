class_name ResourceSpawner extends Node

@export var resource_scenes: Array[PackedScene] = []
@export var spawn_chance_percent: float = 10

@onready var game_state: GameState = %GameState
@onready var resource_filter_node: Node = %Resources

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_random_resources()
	pass # Replace with function body.

func spawn_random_resources() -> void:
	if resource_scenes.size() <= 0:
		return
	
	if not resource_filter_node:
		resource_filter_node = self
	
	
	var grid: GridLayout = game_state.grid
	for i in range(grid.grid_size.x):
		for y in range(grid.grid_size.y):
			var number: int = randi() % 100 + 1
			var resource_spawn: int = randi() % resource_scenes.size()

			# don't even try if chance is too low, checks per cell
			# so, this is quantitative random rather than qualitative
			# meaning there is a non 0% chance that ever cell could be a resource
			if number > spawn_chance_percent:
				continue

			var resource = resource_scenes[resource_spawn].instantiate()
			if resource is BaseResource:
				resource_filter_node.add_child(resource)
				grid.place_item(resource, Vector2i(i, y))
			else:
				print("here")
				resource.queue_free()
				push_error("Resource Spawner Trying To Spawn Unknown Resource!")
	return
