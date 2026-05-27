extends Control

var is_open: bool = false

@onready var inventory: Inventory = preload(
	"res://resources/inventory/player_inventory.tres"
)
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	update()

func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])

func open() -> void:
	visible = true
	is_open = true

func close() -> void:
	visible = false
	is_open = false
