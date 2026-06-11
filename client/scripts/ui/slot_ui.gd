extends Panel

@onready var background_sprite: Sprite2D = $background
@onready var item_sprite: Sprite2D = $CenterContainer/Panel/item
@onready var amount_label: Label = $CenterContainer/Panel/Label
@onready var hover_border: Sprite2D = $CenterContainer/HoverBorder
var is_hovering: bool = false

func update(slot: InventorySlot) -> void:
	if !slot.item:
		background_sprite.frame = 0
		item_sprite.visible = false
		amount_label.visible = false
	else:
		background_sprite.frame = 1
		item_sprite.visible = true
		item_sprite.texture = slot.item.texture
		amount_label.visible = true
		amount_label.text = str(slot.amount)
		
		var sprite_scale_x = item_sprite.scale.x
		var width: float = item_sprite.get_rect().size.x
		if sprite_scale_x >= 1.0:
			item_sprite.scale *= (16.0 / width)

func _on_mouse_entered() -> void:
	hover_border.visible = true
	is_hovering = true

func _on_mouse_exited() -> void:
	hover_border.visible = false
	is_hovering = false

func _on_gui_input(event: InputEvent) -> void:
	if !is_hovering:
		return
		
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_RIGHT:
			$SlotItemContextMenu.visible = true
		else:
			$SlotItemContextMenu.visible = false
