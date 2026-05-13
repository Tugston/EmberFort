class_name GameState extends Node

@export var player_spawn_position: Vector2i = Vector2i.ZERO
@export var castle_spawn_position: Vector2i = Vector2i.ZERO

@onready var player: PlayerController = %Player
@onready var grid: GridLayout = %GridLayout

func _ready() -> void:
	grid.place_item(player, player_spawn_position)
	return
