extends Button

func _on_pressed() -> void:
	var headers = ["Conten-Type: application/json"]
	$HTTPRequest.request_completed.connect(_on_request_completed)
	$HTTPRequest.request("http://localhost:8080/register", headers, HTTPClient.METHOD_POST, "")

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		print("Register successful: ", body.get_string_from_utf8())
	else:
		print("Register failed with response code: ", response_code)
