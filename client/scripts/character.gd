extends CharacterBody2D

const SPEED = 30.0
var damage = 20
var last_direction: String = "down"
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox = $MeleeHitbox

func _physics_process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	update_animation(direction)
	if Input.is_action_just_pressed("attack"):
		perform_attack()
		
	velocity = direction * SPEED 
	
	move_and_slide()
	

	
	

func perform_attack():
	set_physics_process(false)  # Stop movement during attack
	sprite.stop()
	sprite.play("punch_" + last_direction)
	if sprite.is_playing():
		sprite.connect("animation_finished", _on_attack_animation_finished)
	
	var overlapping_objects = hitbox.get_overlapping_bodies()
	
	for object in overlapping_objects:
		if object.has_method("take_damage"):
			object.take_damage(damage)

func _on_attack_animation_finished():
	set_physics_process(true)
	sprite.disconnect("animation_finished", _on_attack_animation_finished)
	
func update_animation(input: Vector2) -> void:
	if input != Vector2.ZERO:
		# Determine the primary direction based on input
		if abs(input.x) > abs(input.y):
			last_direction = "side"
			sprite.flip_h = input.x < 0
		else:
			last_direction = "up" if input.y < 0 else "down"
		
		# Play the animation
		sprite.play("walk_" + last_direction)
	else:
		# When stopping, stay on the walk animation but pause it on the 'idle' frame
		# Usually frame 0 is the neutral standing pose in these sprite sheets
		sprite.play("idle_" + last_direction)
