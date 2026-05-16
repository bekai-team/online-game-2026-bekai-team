extends Node

const SAVE_PATH = "user://session.json"
var access_token = ""

func _ready():
	load_token()

func save_token(token: String):
	access_token = token
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var data = {"token": token}
		file.store_string(JSON.stringify(data))
		file.close()
		print("Токен успішно збережено в LocalStorage!")

func load_token():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var content = file.get_as_text()
		file.close()
		
		var data = JSON.parse_string(content)
		if data and data.has("token"):
			access_token = data["token"]
			print("Сесію відновлено! Знайдено токен.")
			return true
	return false

func clear_token():
	access_token = ""
	var dir = DirAccess.open("user://")
	if dir and dir.file_exists("session.json"):
		dir.remove("session.json")
		print("Токен видалено, сесію закрито.")
