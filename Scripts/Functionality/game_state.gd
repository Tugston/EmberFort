class_name GameState extends Node2D

@export var player_spawn_position: Vector2i = Vector2i.ZERO
@export var castle_spawn_position: Vector2i = Vector2i.ZERO

@onready var player: PlayerController = %Player
@onready var castle: BaseStructure = %HomeTower
@onready var grid: GridLayout = %GridLayout

var selected_entity: BaseEntity = null

var pickaxe_cursor = preload("res://Misc/Cursors/Pickaxe.png")
var axe_cursor = preload("res://Misc/Cursors/Axe.png")

func _ready() -> void:
	grid.place_item(player, player_spawn_position)
	grid.place_item(castle, castle_spawn_position)
	return

func _process(_delta: float) -> void:
	var hovered_entity: BaseEntity = get_hovered_entity()
	if hovered_entity:
		set_cursor(hovered_entity)
	else:
		reset_cursor()

func get_mouse_position() -> Vector2:
	return get_global_mouse_position()

func get_hovered_entity() -> BaseEntity:
	var mouse_pos: Vector2 = get_mouse_position()
	var mouse_grid_pos: Vector2i = grid.world_pos_to_grid_pos(mouse_pos)
	selected_entity = grid.get_entity_in_cell(mouse_grid_pos)
	return selected_entity

#use the entities enum since the grid system finds the entity and gets its tag
func set_cursor(entity_hovered: BaseEntity) -> void:
	match entity_hovered.type:
		BaseEntity.Tags.RESOURCE:
			var resource = entity_hovered as BaseResource
			match resource.resource_type:
				resource.ResourceType.WOOD:
					Input.set_custom_mouse_cursor(axe_cursor)
				resource.ResourceType.STONE:
					Input.set_custom_mouse_cursor(pickaxe_cursor)
	return

func reset_cursor() -> void:
	Input.set_custom_mouse_cursor(null)

func interact_with_entity(interacting_entity: BaseEntity) -> void:
	if selected_entity:
		selected_entity.interact(interacting_entity)
