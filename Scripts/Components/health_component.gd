class_name HealthComponent extends Resource

@export var max_health: float = 100.0
@export var current_health: float = max_health

signal health_changed(new_health)
signal death()

func take_damage(amount: float) -> void:
	current_health = clampf(current_health - amount, 0.0, max_health)
	health_changed.emit(current_health)
	if current_health <= 0:
		kill()
	return

func kill() -> void:
	current_health = 0
	health_changed.emit(current_health)
	death.emit()
	pass
	
func heal(amount: float) -> void:
	current_health = clampf(current_health + amount, 0.0, max_health)
	health_changed.emit(current_health)
	return
