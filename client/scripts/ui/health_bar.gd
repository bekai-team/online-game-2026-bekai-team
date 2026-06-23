extends ProgressBar

@export var player: Character

func _ready() -> void:
	if player:
		player.health_changed.connect(update)
		update()

func update() -> void:
	if player:
		value = player.health
