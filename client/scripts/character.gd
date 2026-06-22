extends CharacterBody2D

class_name Character
signal health_changed

const MAX_HEALTH: int = 100
var health: int = MAX_HEALTH
const SPEED = 70.0
var damage = 20
var last_direction: String = "down"

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

func _physics_process(_delta):
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
	if health <= 0:
		print('Stop fucking my ass!')
		
	health -= amount
	health_changed.emit()

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
		# Determine the primary direction based on input
		if abs(input.x) > abs(input.y):
			last_direction = "side"
			animation_fliph(input.x < 0)
		else:
			last_direction = "up" if input.y < 0 else "down"
		
		# Play the animation
		animation_play("walk_" + last_direction)
	else:
		# When stopping, stay on the walk animation but pause it on the 'idle' frame
		# Usually frame 0 is the neutral standing pose in these sprite sheets
		animation_play("idle_" + last_direction)
