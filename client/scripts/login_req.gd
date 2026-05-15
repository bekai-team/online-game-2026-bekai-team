extends Button

func _on_pressed() -> void:
	$HTTPRequest.request_completed.connect(_on_request_completed)
	$HTTPRequest.request("http://localhost:8080/login")

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var response = JSON.parse_string(body.get_string_from_utf8())
		
		if response and response.has("accessToken"):
			var token = response.get("accessToken")
			
			SessionManager.save_token(token)
			
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			
	else:
		print("Login failed with response code: ", response_code)
