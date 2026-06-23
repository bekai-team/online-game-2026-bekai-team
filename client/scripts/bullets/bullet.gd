extends Node2D

@export var SPEED: int = 1500
@export var BULLET_DAMAGE: int = 20

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position += transform.x * SPEED * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Character:
		return 
	
	print("Bullet penetrted body: {}", body.get_canvas_item())
	
	if body.has_method("take_damage"):
		body.take_damage(BULLET_DAMAGE)
	
	queue_free()
