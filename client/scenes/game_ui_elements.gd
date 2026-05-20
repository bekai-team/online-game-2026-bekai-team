extends Node2D

@export var player: Character
var healthBar: ProgressBar

func _ready() -> void:
	healthBar = $CanvasLayer/HealthBar
	player.health_changed.connect(update)
	update()

func _process(delta: float) -> void:
	pass

func update() -> void:
	healthBar.value = player.health
