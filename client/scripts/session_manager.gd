extends Node

var access_token = ""

func save_token(token: String):
	access_token = token
	if OS.has_feature("web"):
		JavaScriptBridge.eval("localStorage.setItem('accessToken', '%s');" % token)
		print("Токен збережено в браузерний LocalStorage")
	else:
		var file = FileAccess.open("user://session.json", FileAccess.WRITE)
		if file:
			file.store_string(JSON.stringify({"token": token}))
			file.close()

func load_token() -> bool:
	if OS.has_feature("web"):
		var token = JavaScriptBridge.eval("localStorage.getItem('accessToken');")
		if token != null and token != "":
			access_token = token
			print("Токен відновлено з LocalStorage")
			return true
	else:
		if FileAccess.file_exists("user://session.json"):
			var file = FileAccess.open("user://session.json", FileAccess.READ)
			var data = JSON.parse_string(file.get_as_text())
			if data and data.has("token"):
				access_token = data["token"]
				return true
	return false
