class_name InventoryComponent extends Node

@export var size: int = 12

signal inventory_updated
signal inventory_dropped

var slots: Array[InventorySlot] = []

func _init() -> void:
	slots.resize(size)
	slots.fill(null)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	return

func debug_display() -> void:
	for i in range(slots.size()):
		var x = slots[i]
		if x != null:
			print("SLOT ", i, ":")
			print(x.occupied_item.item_name)
			print(x.current_quantity)
			print("--------------------")
			print("\n".repeat(3))

func add_item(item: InventoryItem, quantity: int) -> bool:
	var available_slots: Array[int] = _check_inventory_room(item)
	if available_slots.size() <= 0:
		return false
	
	var remainder: int = _fill_slots(item, available_slots, quantity)
	inventory_updated.emit()
	
	if remainder > 0:
		inventory_dropped.emit()
	return true

func remove_item() -> bool:
	return true

#checks to see if there is space for item
#this includes a new slot
#if there is space, return the indexes
func _check_inventory_room(item: InventoryItem) -> Array[int]:
	var contains_item_idxs: Array[int] = []
		
	#grab all indexes that have same item
	#plus the empty slots
	for idx in range(slots.size()):
		var slot = slots[idx]
		
		if slot == null:
			contains_item_idxs.append(idx)
			continue
		
		if slot.occupied_item == item and slot.current_quantity < item.max_stack:
				contains_item_idxs.append(idx)
		
	return contains_item_idxs

#returns remained that couldn't be filled
func _fill_slots(item: InventoryItem, slot_idxs: Array[int], quantity: int) -> int:
	var remaining_qnty: int = quantity
	for i in slot_idxs:
		if remaining_qnty <= 0:
			break
		
		if slots[i] == null:
			slots[i] = InventorySlot.new()
			slots[i].occupied_item = item
		
		var available_qnty: int = item.max_stack - slots[i].current_quantity
		if available_qnty <= remaining_qnty:
			slots[i].current_quantity += available_qnty
			remaining_qnty -= available_qnty
		else:
			slots[i].current_quantity += remaining_qnty
			remaining_qnty = 0
	return remaining_qnty
