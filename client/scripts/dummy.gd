extends CharacterBody2D

var max_hp = 100
var current_hp = 100

@onready var health_bar = $ProgressBar

func _ready():
	health_bar.max_value = max_hp
	health_bar.value = current_hp

func take_damage(amount):
	current_hp -= amount
	health_bar.value = current_hp
	
	print("Манекен отримав ", amount, " шкоди! Залишилось HP: ", current_hp)
	
	if current_hp <= 0:
		print("Манекен знищено!")
		queue_free()
