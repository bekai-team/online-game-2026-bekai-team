extends Node

var access_token: String = ""
var refresh_token: String = ""

const BASE_URL = "http://localhost:3000/api/auth"

func save_tokens(new_access: String, new_refresh: String) -> void:
	access_token = new_access
	refresh_token = new_refresh
	
	if OS.has_feature("web"):
		JavaScriptBridge.eval("localStorage.setItem('accessToken', '" + access_token + "');")
		JavaScriptBridge.eval("localStorage.setItem('refreshToken', '" + refresh_token + "');")
	print("Токени успішно збережено в системі!")

func get_access_token() -> String:
	if access_token.is_empty() and OS.has_feature("web"):
		var res = JavaScriptBridge.eval("localStorage.getItem('accessToken');")
		if res: access_token = str(res)
	return access_token

func get_refresh_token() -> String:
	if refresh_token.is_empty() and OS.has_feature("web"):
		var res = JavaScriptBridge.eval("localStorage.getItem('refreshToken');")
		if res: refresh_token = str(res)
	return refresh_token

func refresh_session() -> void:
	var r_token = get_refresh_token()
	if r_token.is_empty():
		print("Неможливо оновити сесію: відсутній refresh_token")
		_handle_session_expired()
		return
		
	var http_request = HTTPRequest.new()
	add_child(http_request)
	
	var headers = [
		"Content-Type: application/json",
		"Authorization: Bearer " + r_token
	]
	
	http_request.request_completed.connect(func(result, response_code, headers, body):
		if response_code == 200 or response_code == 201:
			var json = JSON.parse_string(body.get_string_from_utf8())
			if json and json.has("accessToken") and json.has("refreshToken"):
				save_tokens(json["accessToken"], json["refreshToken"])
				print("Сесію успішно оновлено через /api/auth/refresh!")
		else:
			print("Помилка оновлення токена. Код: ", response_code)
			_handle_session_expired()
		http_request.queue_free()
	)
	
	http_request.request(BASE_URL + "/refresh", headers, HTTPClient.METHOD_POST, "")

func logout_user() -> void:
	var a_token = get_access_token()
	var http_request = HTTPRequest.new()
	add_child(http_request)
	
	var headers = ["Content-Type: application/json"]
	if not a_token.is_empty():
		headers.append("Authorization: Bearer " + a_token)
		
	http_request.request_completed.connect(func(result, response_code, headers, body):
		print("Сервер обробив logout з кодом: ", response_code)
		clear_session_locally()
		http_request.queue_free()
	)
	
	http_request.request(BASE_URL + "/logout", headers, HTTPClient.METHOD_POST, "")

func clear_session_locally() -> void:
	access_token = ""
	refresh_token = ""
	if OS.has_feature("web"):
		JavaScriptBridge.eval("localStorage.removeItem('accessToken');")
		JavaScriptBridge.eval("localStorage.removeItem('refreshToken');")
	get_tree().change_scene_to_file("res://scenes/login.tscn")

func _handle_session_expired() -> void:
	clear_session_locally()
