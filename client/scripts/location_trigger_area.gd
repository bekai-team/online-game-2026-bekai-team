extends Area2D

@export var target_area_name: String = 'PickUpBox'
@export var target_level_to_load: PackedScene

func _on_area_entered(area: Area2D) -> void:
	#var belongs_to_player = 
	print(area.get_parent())
	if area.name == target_area_name:
		get_tree().change_scene_to_packed(target_level_to_load)
