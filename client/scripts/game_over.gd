extends CanvasLayer

@onready var countdown_label = %CountdownLabel

var time_left = 5 

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	_start_respawn_countdown()

func _start_respawn_countdown():
	while time_left > 0:
		countdown_label.text = "Повернення в хаб через: " + str(time_left) + " сек..."
		await get_tree().create_timer(1.0, true).timeout
		time_left -= 1
	
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/world.tscn") 
