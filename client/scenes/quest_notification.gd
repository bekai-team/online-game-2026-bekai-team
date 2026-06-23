extends Label

func _ready():
	hide() 

func show_message(text: String, duration: float = 5.0):
	self.text = text
	show()
	await get_tree().create_timer(duration).timeout
	hide()
