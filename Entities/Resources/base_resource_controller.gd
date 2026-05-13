class_name BaseResource extends BaseEntity

@onready var sprite: Sprite2D = $Sprite
@export var textures: Array[Texture2D]

func _ready() -> void:
	if textures and textures.size() > 0:
		var index: int = randi() % textures.size()
		sprite.texture = textures[index]
	
	sprite.scale *= 2.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
