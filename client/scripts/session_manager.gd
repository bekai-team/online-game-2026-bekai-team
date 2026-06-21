extends Node

const SAVE_PATH = "user://session.json"
var access_token = ''
var email: String = ''

func _ready():
	load_token()

func save_data(token: String, email: String):
	access_token = token
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var data = {"accessToken": token, "email": email}
		file.store_string(JSON.stringify(data))
		file.close()
		print("Токен успішно збережено в LocalStorage!")

func get_data():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var content = file.get_as_text()
		file.close()
		
		var data = JSON.parse_string(content)
		return data
	else:
		return null

func load_token():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var content = file.get_as_text()
		file.close()
		
		var data = JSON.parse_string(content)
		if data and data.has("accessToken"):
			access_token = data["accessToken"]
			email = data['email']
			print('Loaded')
			print(access_token)
			print(email)
			print("Сесію відновлено! Знайдено токен.")
			return true
	return false

func clear_data():
	access_token = ""
	email = ''
	var dir = DirAccess.open("user://")
	if dir and dir.file_exists("session.json"):
		dir.remove("session.json")
		print("Токен видалено, сесію закрито.")
