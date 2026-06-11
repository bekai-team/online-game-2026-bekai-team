extends Control

func _on_use_item_button_pressed(slot: InventorySlot) -> void:
	if !slot.item:
		OS.alert('DD')
	else:
		OS.alert(str(slot.amount))

func _on_drop_item_button_pressed() -> void:
	OS.alert("Sussy")
