extends Button

@onready var email_input = $"../EmailInput"
@onready var password_input = $"../PasswordInput"
@onready var http_request = $HTTPRequest

func _on_pressed() -> void:
	if email_input.text.is_empty() or password_input.text.is_empty():
		print("Помилка: Заповніть усі поля для реєстрації!")
		return
		
	var signup_data = {
		"email": email_input.text,
		"password": password_input.text
	}
	var body = JSON.stringify(signup_data)
	var headers = ["Content-Type: application/json"] 
	
	if not http_request.request_completed.is_connected(_on_request_completed):
		http_request.request_completed.connect(_on_request_completed)
		
	var url = "http://localhost:8080/api/auth/signup"
	http_request.request(url, headers, HTTPClient.METHOD_POST, body)
	print("Запит на реєстрацію відправлено...")

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200 or response_code == 201:
		print("Реєстрація успішна! Тепер можна увійти.")
	else:
		print("Помилка реєстрації! Код: ", response_code)
