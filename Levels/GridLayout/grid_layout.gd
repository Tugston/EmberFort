class_name GridLayout extends Node

@export var grid_size: Vector2i = Vector2i.ZERO
@export var tilemap_scale: float = 2.5
@export var cell_size: float = 32.0

var grid_data: Dictionary[Vector2i, BaseEntity] = {}

func _ready() -> void:
	cell_size *= tilemap_scale
	return

func grid_pos_to_world_pos(grid_position: Vector2i) -> Vector2:
	return Vector2(grid_position * cell_size) + Vector2(cell_size / 2, cell_size / 2)

func world_pos_to_grid_pos(world_pos: Vector2) -> Vector2i:
	return Vector2i((world_pos / cell_size).floor())

#spawn new item
func place_item(entity: BaseEntity, grid_position: Vector2i) -> bool:
	if _validate_position(grid_position):
		grid_data[grid_position] = entity
		entity.position = grid_pos_to_world_pos(grid_position)
		entity.grid_position = grid_position
		return true
	return false

#the item is being destroyed
func remove_item(position: Vector2i) -> bool:
	if grid_data.has(position):
		grid_data.erase(position)
		return true
	return false

#not calling the remove and place functions
#in order to not validate three times
func move_item(entity: BaseEntity, grid_position: Vector2i) -> bool:
	if _validate_position(grid_position):
		grid_data.erase(entity.grid_position)
		grid_data[grid_position] = entity
		entity.position = grid_pos_to_world_pos(grid_position)
		entity.grid_position = grid_position
		return true
	return false

#returns null if the object is not found
func get_entity_in_cell(grid_position: Vector2i) -> BaseEntity:
	if grid_data.has(grid_position):
		return grid_data[grid_position]
	return null

#returns true if the position is not occupied and is valid
func _validate_position(position: Vector2i) -> bool:
	if not grid_data.has(position) and position.x >= 0 and position.y >= 0 and position.x <= grid_size.x and position.y <= grid_size.y:
		return true
	return false
