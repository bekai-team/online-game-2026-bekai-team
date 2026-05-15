extends HTTPRequest

func _ready():
	timeout = 2.0 
	request_completed.connect(_on_request_completed)

func send_prompt_to_ai(prompt: String):
	var url = "http://127.0.0.1:8080/api/llm/generate" 
	var headers = ["Content-Type: application/json"]
	var body = JSON.stringify({"prompt": prompt})
	
	print("Відправляємо запит до ШІ...")
	request(url, headers, HTTPClient.METHOD_POST, body)

func _on_request_completed(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_TIMEOUT:
		print("Помилка: ШІ думає занадто довго (більше 2 секунд). Таймаут!")
		return
		
	if response_code == 200:
		print("Відповідь ШІ: ", body.get_string_from_utf8())
	else:
		print("Помилка сервера: ", response_code)
