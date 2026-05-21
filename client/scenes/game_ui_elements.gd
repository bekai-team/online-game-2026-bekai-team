extends Node2D

@export var player: Character
@onready var healthBar: TextureProgressBar = $CanvasLayer/TextureProgressBar

func _ready() -> void:
	if player:
		player.health_changed.connect(update)
		update()
	else:
		push_error("UI could not find the Player node in the scene tree!")

func _process(delta: float) -> void:
	pass

func update() -> void:
	healthBar.value = player.health
