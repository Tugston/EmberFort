class_name BaseEntity extends Node2D

enum Tags {DEFAULT, STRUCTURE, ENEMY, RESOURCE}

@export var type: Tags

var grid_position: Vector2i = Vector2i.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func interact(interacting_entity: BaseEntity) -> void:
	print("Interacted with Entity at ", grid_position)
	return
