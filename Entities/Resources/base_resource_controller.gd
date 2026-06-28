class_name BaseResource extends BaseEntity

enum ResourceType {WOOD, STONE}

@onready var sprite: Sprite2D = $Sprite

@export var textures: Array[Texture2D]
@export var resource_type: ResourceType
@export var harvested_item: ResourceItem
@export var yield_min: int = 1
@export var yield_max: int = 3

func _ready() -> void:
	set_process(false)
	
	if textures and textures.size() > 0:
		var index: int = randi() % textures.size()
		sprite.texture = textures[index]
	
	sprite.scale *= 2.5

func interact(interacting_entity: BaseEntity) -> void:
	var inventory: InventoryComponent = interacting_entity.get_node("InventoryComponent")
	var yield_amnt = randi() % yield_max + yield_min
	
	if harvested_item:
		inventory.add_item(harvested_item, yield_amnt)
		
	return
