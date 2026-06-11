extends Node2D

@export var spawn_object: PackedScene
@export var followed_to: Node2D
@export_range(1, 100) var count: int = 1
var rng = RandomNumberGenerator.new()
@onready var radius = $SpawnArea/CollisionShape2D.shape.radius

func _on_spawn_area_area_entered(area: Area2D) -> void:
	if area.name != 'PickUpBox':
		return
		
	if spawn_object:
		for i in range(count):
			var new_spawn = spawn_object.instantiate()
			var random_angle = randf_range(0, TAU)
			var random_distance = sqrt(randf()) * radius
			
			var spawn_offset = Vector2(
				cos(random_angle), sin(random_angle)
			) * random_distance
			
			new_spawn.global_position = global_position + spawn_offset
			new_spawn.Goal = followed_to
			
			get_tree().current_scene.add_child(new_spawn)
