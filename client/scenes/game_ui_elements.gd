extends Node2D

@export var player: Character
var healthBar: TextureProgressBar

func _ready() -> void:
	healthBar = $CanvasLayer/TextureProgressBar
	player.health_changed.connect(update)
	update()

func _process(delta: float) -> void:
	pass

func update() -> void:
	healthBar.value = player.health
