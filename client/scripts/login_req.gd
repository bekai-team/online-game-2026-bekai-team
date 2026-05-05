extends Button

func _on_pressed() -> void:
	$HTTPRequest.request_completed.connect(_on_request_completed)
	$HTTPRequest.request("http://localhost:8080/login")

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		print("Login successful: ", body.get_string_from_utf8())
	else:
		print("Login failed with response code: ", response_code)
