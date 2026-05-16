extends Button

@onready var email_input = $"../EmailInput" 
@onready var password_input = $"../PasswordInput"
@onready var http_request = $HTTPRequest

func _on_pressed() -> void:
	if email_input.text.is_empty() or password_input.text.is_empty():
		print("Помилка: Заповніть усі поля!")
		return
		
	var auth_data = {
		"email": email_input.text,
		"password": password_input.text
	}
	var body = JSON.stringify(auth_data)
	var headers = ["Content-Type: application/json"]
	
	if not http_request.request_completed.is_connected(_on_request_completed):
		http_request.request_completed.connect(_on_request_completed)
		
	var url = "http://localhost:3000/api/auth/login"
	http_request.request(url, headers, HTTPClient.METHOD_POST, body)
	print("Запит на авторизацію відправлено...")

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200 or response_code == 201:
		var response_text = body.get_string_from_utf8()
		var json_data = JSON.parse_string(response_text)
		
		if json_data and json_data.has("accessToken"):
			if has_node("/root/SessionManager"):
				get_node("/root/SessionManager").save_token(json_data["accessToken"])
			print("Авторизація успішна! Токен збережено.")
	else:
		print("Помилка входу! Код: ", response_code)
