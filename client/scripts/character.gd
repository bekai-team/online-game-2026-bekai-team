extends CharacterBody2D

class_name Character
signal health_changed

const MAX_HEALTH: int = 100
var health: int = MAX_HEALTH
const SPEED = 70.0
var damage = 20
var last_direction: String = "down"
var is_dead: bool = false

@onready var body: AnimatedSprite2D = $Skeleton/Body/Sprite
@onready var upper: AnimatedSprite2D = $Skeleton/Upper/Sprite
@onready var bottom: AnimatedSprite2D = $Skeleton/Bottom/Sprite
@onready var hitbox = $MeleeHitbox

@export var inventory: Inventory

func _ready() -> void:
	body.frame = 0
	upper.frame = 0
	bottom.frame = 0
	animation_play("idle_down")
	
	upper.modulate = Global.player_clothes_color
	body.modulate = Global.player_skin_color
	start_autosave()

func _physics_process(_delta):
	if is_dead: return 
	
	#2. КНОПКА "К" ДЛЯ ТЕСТУВАННЯ СМЕРТІ
	if Input.is_key_pressed(KEY_K):
		take_damage(25)
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	update_animation(direction)
	if Input.is_action_just_pressed("attack"):
		perform_attack()
		
	velocity = direction * SPEED 
	
	move_and_slide()
	
func animation_play(anim: String):
	body.play(anim)
	upper.play(anim)
	bottom.play(anim)
	
func animation_stop():
	body.stop()
	upper.stop()
	bottom.stop()
	
func animation_fliph(cond: bool):
	body.flip_h = cond
	upper.flip_h = cond
	bottom.flip_h = cond
	
func take_damage(amount: int) -> void:
	if is_dead: return 
	
	if health <= 0:
		print('Stop fucking my ass!')
		
	health -= amount
	health_changed.emit()
	
	if health <= 0:
		die()

func perform_attack():
	animation_stop()
	animation_play("punch_" + last_direction)
	if body.is_playing():
		body.connect("animation_finished", _on_attack_animation_finished)
	
	var overlapping_objects = hitbox.get_overlapping_bodies()
	
	for object in overlapping_objects:
		if object.has_method("take_damage"):
			object.take_damage(damage)

func _on_attack_animation_finished():
	set_physics_process(true)
	body.disconnect("animation_finished", _on_attack_animation_finished)
	
func update_animation(input: Vector2) -> void:
	if input != Vector2.ZERO:
		if abs(input.x) > abs(input.y):
			last_direction = "side"
			animation_fliph(input.x < 0)
		else:
			last_direction = "up" if input.y < 0 else "down"
		
		animation_play("walk_" + last_direction)
	else:
		animation_play("idle_" + last_direction)
		
func start_autosave():
	var save_req = HTTPRequest.new()
	add_child(save_req)
	
	while true:
		await get_tree().create_timer(60.0).timeout
		if SessionManager.access_token != "":
			var data = {
				"position_x": global_position.x, 
				"position_y": global_position.y
			}
			var headers = [
				"Content-Type: application/json", 
				"Authorization: Bearer " + SessionManager.access_token
			]
			save_req.request("http://localhost:3000/api/inventory", headers, HTTPClient.METHOD_POST, JSON.stringify(data))

func die():
	is_dead = true
	velocity = Vector2.ZERO 
	animation_play("idle_down") 
	
	var game_over_scene = load("res://scenes/game_over.tscn")
	if game_over_scene:
		var game_over_instance = game_over_scene.instantiate()
		get_tree().current_scene.add_child(game_over_instance)
	else:
		print("ПОМИЛКА: Сцену game_over.tscn не знайдено за цим шляхом!")
