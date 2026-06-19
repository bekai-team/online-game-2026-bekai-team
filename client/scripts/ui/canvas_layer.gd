extends CanvasLayer

@onready var inventory_ui = $InventoryUi

func _ready() -> void:
	inventory_ui.close()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		if inventory_ui.is_open:
			inventory_ui.close()
		else:
			inventory_ui.open()
