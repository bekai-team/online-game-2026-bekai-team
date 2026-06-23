extends Area2D

@export var target_area_name: String = 'PickUpBox'
@export_file("*.tscn") var target_level_path: String

func _on_area_entered(area: Area2D) -> void:
	if area.name == target_area_name:
		if target_level_path != "":
			get_tree().change_scene_to_file(target_level_path)
		else:
			push_error("ERROR (target_level_path) wasn't set in inspector!")
