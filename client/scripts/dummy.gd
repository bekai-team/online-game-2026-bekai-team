extends CharacterBody2D

var max_hp = 100
var current_hp = 100

@onready var health_bar = $ProgressBar

var target_position: Vector2 
var lerp_speed: float = 15.0 

func _ready():
	if health_bar:
		health_bar.max_value = max_hp
		health_bar.value = current_hp
		
	target_position = global_position

func _process(delta):
	global_position = global_position.lerp(target_position, lerp_speed * delta)


func update_network_position(new_pos: Vector2):
	target_position = new_pos

func take_damage(amount):
	current_hp -= amount
	if health_bar:
		health_bar.value = current_hp
	
	print("Манекен отримав ", amount, " шкоди! Залишилось HP: ", current_hp)
	
	if current_hp <= 0:
		print("Манекен знищено!")
		queue_free()
