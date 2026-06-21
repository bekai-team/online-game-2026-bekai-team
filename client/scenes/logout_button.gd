extends Button

@onready var http_request: HTTPRequest = $HTTPRequest
var logout_url = "http://localhost:3001/api/auth/login"

func _ready():
	http_request.request_completed.connect(_on_http_request_request_completed)

func _on_pressed() -> void:
	#var json_data = JSON.stringify(
		#{'accessToken': SessionManager.access_token}
	#)
	#var headers = ["Content-Type: application/json"]
	#http_request.request(
		#logout_url, 
		#headers, 
		#HTTPClient.METHOD_POST, 
		#json_data)
	SessionManager.clear_data()
	visible = false
	
func _on_http_request_request_completed(
	result: int, 
	response_code: int, 
	headers: PackedStringArray, 
	body: PackedByteArray) -> void:
	if response_code == 200:
		var response_data = JSON.parse_string(body.get_string_from_utf8())
		
		if response_data:
			OS.alert('Logout successful!')
			
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	else:
		OS.alert("Помилка (Код: " + str(response_code) + ")")
