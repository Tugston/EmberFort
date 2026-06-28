class_name PlayerController extends BaseEntity

@export var speed: float = 400

@onready var game_state: GameState = %GameState
@onready var input_component: InputComponent = $InputComponent
@onready var movement_component: MovementComponent = $MovementComponent
@onready var inventory_component: InventoryComponent = $InventoryComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if movement_component:
		movement_component.grid = game_state.grid
	if input_component:
		input_component.action_interact.connect(_on_interact_trigger)
	return # Replace with function body.

func _physics_process(_delta: float) -> void:
	var move_dir: Vector2i = input_component.update()
	if move_dir != Vector2i.ZERO:
		movement_component.move(move_dir)
	return

func _on_interact_trigger() -> void:
	game_state.interact_with_entity(self)
	inventory_component.debug_display()
	return
