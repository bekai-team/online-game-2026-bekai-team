extends ProgressBar

@export var player: Character

func _ready() -> void:
	update()

func _process(delta: float) -> void:
	pass

func update() -> void:
	value = player.health
