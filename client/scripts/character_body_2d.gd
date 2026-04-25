extends CharacterBody2D

const SPEED = 300.0
var damage = 20


@onready var hitbox = $MeleeHitbox

func _physics_process(delta):
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()
	

	
	if Input.is_action_just_pressed("attack"):
		perform_attack()

func perform_attack():
	
	var overlapping_objects = hitbox.get_overlapping_bodies()
	
	for object in overlapping_objects:
		if object.has_method("take_damage"):
			object.take_damage(damage)
