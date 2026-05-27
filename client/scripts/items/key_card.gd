extends Collectable

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == 'PickUpBox':
		collect(area.get_parent().inventory)
