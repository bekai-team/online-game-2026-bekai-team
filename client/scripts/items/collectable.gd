extends Node2D
class_name Collectable

@export var item_res: InventoryItem

func collect(inventory: Inventory) -> void:
	inventory.insert(item_res)
	queue_free()
