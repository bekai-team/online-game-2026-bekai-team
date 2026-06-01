extends CharacterBody2D

const movement_speed: float = 50.0
const max_hp = 100
var current_hp = 100

@onready var health_bar = $ProgressBar
@onready var nav_agent = $NavigationAgent2D
@onready var sprite = $AnimatedSprite2D
@export var Goal: Node = null

func _ready() -> void:
	if is_instance_valid(Goal):
		$NavigationAgent2D.target_position = Goal.global_position
	
	health_bar.max_value = max_hp
	health_bar.value = current_hp

func _physics_process(delta: float) -> void:
	if not is_instance_valid(Goal):
		return

	nav_agent.target_position = Goal.global_position
	
	if nav_agent.is_navigation_finished():
		return

	var next_path_pos: Vector2 = nav_agent.get_next_path_position()
	var current_pos: Vector2 = global_position
	
	var new_velocity: Vector2 = (
		next_path_pos - current_pos
	).normalized() * movement_speed
	
	play_animations(new_velocity)
	
	velocity = new_velocity
	move_and_slide()

func play_animations(move_dir: Vector2) -> void:
	if move_dir.length() < 0.1:
		return 

	if move_dir.x > 0.5:
		sprite.play("right")
	elif move_dir.x < -0.5:
		sprite.play("left")
	elif move_dir.y > 0.5:
		sprite.play("down")
	elif move_dir.y < -0.5:
		sprite.play("up")


func take_damage(amount):
	current_hp -= amount
	health_bar.value = current_hp
	
	print("Щур отримав ", amount, " шкоди! Залишилось HP: ", current_hp)
	
	if current_hp <= 0:
		print("Кілограм щура")
		queue_free()
