extends Node2D

@export var spawn_object: PackedScene
@export var followed_to: Node2D

func _on_spawn_area_area_entered(area: Area2D) -> void:
	if area.name == 'PickUpBox':
		print("entered player!")
		
		if spawn_object:
			var new_spawn = spawn_object.instantiate()
			new_spawn.global_position = global_position
			
			new_spawn.Goal = followed_to
			
			get_tree().current_scene.add_child(new_spawn)
