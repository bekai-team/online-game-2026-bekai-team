extends Node2D

@onready var collider: Area2D = $Area2D
const SHOTGUN = preload("res://scenes/weaponary/shotgun.tscn")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func pick_logic(character: Node2D) -> void:
	var spawned_shotgun = SHOTGUN.instantiate()
	var hands_marker: Marker2D = character.get_node('HandsMarker')
	
	if !hands_marker.get_children():
		hands_marker.add_child(spawned_shotgun)
	queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == 'PickUpBox':
		var character: Node2D = area.get_parent()
		pick_logic(character)
