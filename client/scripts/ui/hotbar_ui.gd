extends Control

var is_open: bool = false

@onready var inventory: Inventory = preload(
	"res://resources/inventory/player_inventory.tres"
)
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	inventory.updated.connect(update)
	update()

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])
