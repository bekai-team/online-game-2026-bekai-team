extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Character": 
		get_tree().change_scene_to_file("res://scenes/hub.tscn")
