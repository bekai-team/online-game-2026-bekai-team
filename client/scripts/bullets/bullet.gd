extends Node2D

@export var SPEED: int = 1500

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position += transform.x * SPEED * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
