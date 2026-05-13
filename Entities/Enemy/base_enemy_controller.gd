class_name BaseEnemyController extends BaseEntity

var target_tower: BaseStructure = null

@export var game_state: GameState

@onready var movement_component: MovementComponent = $MovementComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta: float) -> void:
	#if target_tower:
		#var dir = Vector2(target_tower.position - position).normalized()
		#movement_component.update_area(dir, delta)
		
#	return
