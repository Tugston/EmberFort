class_name MovementComponent extends Node

@onready var owning_entity: BaseEntity = owner

@export var grid: GridLayout

func _ready() -> void:
	set_physics_process(false)
	return	

func move(move_dir) -> void:
	var move_pos: Vector2i = owning_entity.grid_position + move_dir
	grid.move_item(owning_entity, move_pos)
	#print(move_dir)
	return
