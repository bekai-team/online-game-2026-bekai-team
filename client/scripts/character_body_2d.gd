extends CharacterBody2D

const SPEED = 30.0
var damage = 20
var last_direction = Vector2.DOWN
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox = $MeleeHitbox

func _physics_process(_delta):
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction != Vector2.ZERO:
		last_direction = direction
		match direction:
			Vector2.LEFT:
				sprite.play("walk_side")
				sprite.flip_h = true
			Vector2.RIGHT:
				sprite.play("walk_side")
				sprite.flip_h = false
			Vector2.UP:
				sprite.play("walk_up")
			Vector2.DOWN:
				sprite.play("walk_down")
	else: 
		match last_direction:
			Vector2.LEFT:
				sprite.play("idle_side")
				sprite.flip_h = true
			Vector2.RIGHT:
				sprite.play("idle_side")
				sprite.flip_h = false
			Vector2.UP:
				sprite.play("idle_up")
			Vector2.DOWN:
				sprite.play("idle_down")

	velocity = direction * SPEED 
	
	move_and_slide()
	

	
	if Input.is_action_just_pressed("attack"):
		perform_attack()

func perform_attack():
	set_physics_process(false)  # Stop movement during attack
	sprite.stop()
	match last_direction:
		Vector2.LEFT:
			sprite.play("punch_side")
			sprite.flip_h = true
		Vector2.RIGHT:
			sprite.play("punch_side")
			sprite.flip_h = false
		Vector2.UP:
			sprite.play("punch_up")
		Vector2.DOWN:
			sprite.play("punch_down")
	if sprite.is_playing():
		sprite.connect("animation_finished", _on_attack_animation_finished)
	
	var overlapping_objects = hitbox.get_overlapping_bodies()
	
	for object in overlapping_objects:
		if object.has_method("take_damage"):
			object.take_damage(damage)
	

func _on_attack_animation_finished():
	set_physics_process(true)  # Resume movement after attack
