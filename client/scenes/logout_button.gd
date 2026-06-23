extends Button

@onready var http_request: HTTPRequest = $HTTPRequest
var logout_url = "http://localhost:3000/api/auth/logout"

func _ready():
	http_request.request_completed.connect(_on_http_request_request_completed)

func _on_pressed() -> void:
	var headers = ["Authorization: Bearer %s" % SessionManager.access_token]
	http_request.request(
		logout_url, 
		headers, 
		HTTPClient.METHOD_POST)
	SessionManager.clear_data()
	visible = false
	
func _on_http_request_request_completed(
	result: int, 
	response_code: int, 
	headers: PackedStringArray, 
	body: PackedByteArray) -> void:
	if response_code == 200 or response_code == 201:
		var response_data = JSON.parse_string(body.get_string_from_utf8())
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	else:
		OS.alert("Помилка (Код: " + str(response_code) + ")")
