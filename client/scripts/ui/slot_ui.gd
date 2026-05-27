extends Panel

@onready var background_sprite: Sprite2D = $background
@onready var item_sprite: Sprite2D = $CenterContainer/Panel/item

func update(item: InventoryItem) -> void:
	if !item:
		background_sprite.frame = 0
		item_sprite.visible = false
	else:
		background_sprite.frame = 1
		item_sprite.visible = true
		item_sprite.texture = item.texture
		
		var sprite_scale_x = item_sprite.scale.x
		var width: float = item_sprite.get_rect().size.x
		if sprite_scale_x >= 1.0:
			item_sprite.scale *= (16.0 / width)
