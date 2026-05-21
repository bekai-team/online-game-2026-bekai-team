extends Node2D

@onready var collider: Area2D = $Area2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pick_logic()

func pick_logic():
	print(collider.get_overlapping_areas())
	var objects: Array[Area2D] = collider.get_overlapping_areas()
	
	for object in objects:
		if object.name == 'PlayerPickupArea':
			queue_free()
