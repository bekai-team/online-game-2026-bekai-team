extends Button

@onready var email_input = $"../LineEdit3"
@onready var password_input = $"../LineEdit2"
@onready var error_label = $"../ErrorLabel"
@onready var http_request = $HTTPRequest

var login_url = "http://localhost:3001/api/auth/login"

func _ready():
	http_request.request_completed.connect(_on_request_completed)

func _on_pressed() -> void:
	error_label.add_theme_color_override("font_color", Color.WHITE)
	error_label.text = "З'єднання..."
	
	var data = {
		"email": email_input.text,
		"password": password_input.text
	}
	var json_data = JSON.stringify(data)
	var headers = ["Content-Type: application/json"]
	
	http_request.request(login_url, headers, HTTPClient.METHOD_POST, json_data)

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		error_label.add_theme_color_override("font_color", Color.GREEN)
		error_label.text = "Успіх!"
		
		# Зберігаємо токен у твій SessionManager
		var response_data = JSON.parse_string(body.get_string_from_utf8())
		if response_data and response_data.has("token"):
			SessionManager.save_token(response_data["token"])
			
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	else:
		error_label.add_theme_color_override("font_color", Color.RED)
		error_label.text = "Помилка (Код: " + str(response_code) + ")"
