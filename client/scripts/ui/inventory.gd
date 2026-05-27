extends Resource

class_name Inventory

signal updated
@export var items: Array[InventoryItem]

func insert(item: InventoryItem) -> void:
	for i in range(items.size()):
		if !items[i]:
			items[i] = item
			updated.emit()
			break
