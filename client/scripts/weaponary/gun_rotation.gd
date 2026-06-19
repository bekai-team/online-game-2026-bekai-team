extends Node2D

@onready var muzzle: Marker2D = $Marker2D
@onready var timer: Timer = $Timer
@onready var shots_available: bool = true
const BULLET = preload("res://scenes/bullets/bullet.tscn")
var past_scale: float
var screen_pos: Vector2

func _ready() -> void:
	past_scale = scale.y
	screen_pos = get_global_transform_with_canvas().get_origin()

func _physics_process(delta: float) -> void:
	var bullet_instance: Node
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -past_scale
		
	else:
		scale.y = past_scale
	
	if Input.is_action_just_pressed("attack") and shots_available:
		shoot(bullet_instance)

func shoot(bullet_instance: Node):
	shots_available = false
	timer.start(1.2)
	bullet_instance = BULLET.instantiate()
	get_tree().root.add_child(bullet_instance)
	
	bullet_instance.global_position = muzzle.global_position
	bullet_instance.rotation = rotation
	
	$ShootSound.pitch_scale = randf_range(0.9, 1.1)
	$ShootSound.play()
	
	rotate(0.1745)


func _on_timer_timeout() -> void:
	shots_available = true
