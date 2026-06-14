extends Button

@onready var email_input = $"../LineEdit3"
@onready var password_input = $"../LineEdit2"
@onready var repeat_input = $"../LineEdit4"
@onready var error_label = $"../ErrorLabel"
@onready var http_request = $HTTPRequest

var port = "3001" 
@onready var register_url = "http://localhost:" + port + "/api/auth/sign-up" # Виправлено на sign-up

func _ready():
	http_request.request_completed.connect(_on_request_completed)

func _on_pressed() -> void:
	if password_input.text != repeat_input.text:
		show_error("Паролі не збігаються!")
		return

	error_label.add_theme_color_override("font_color", Color.WHITE)
	error_label.text = "Реєстрація..."
	
	var gen_username = email_input.text.split("@")[0]
	if gen_username == "":
		gen_username = "player"
	
	var data = {
		"username": gen_username,
		"email": email_input.text,
		"password": password_input.text
	}
	var json_data = JSON.stringify(data)
	var headers = ["Content-Type: application/json"]
	
	http_request.request(register_url, headers, HTTPClient.METHOD_POST, json_data)

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200 or response_code == 201:
		error_label.add_theme_color_override("font_color", Color.GREEN)
		error_label.text = "Успіх! Поверніться і увійдіть."
	else:
		show_error("Помилка реєстрації (Код: " + str(response_code) + ")")

func show_error(msg: String):
	error_label.add_theme_color_override("font_color", Color.RED)
	error_label.text = msg
