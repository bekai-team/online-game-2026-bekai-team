extends Node

var active_quests: Array = []

# Ендпоінт для квестів на бекенді
const QUEST_API_URL = "http://localhost:8080/api/quest"

func accept_quest(quest_id: String, quest_title: String):
	for quest in active_quests:
		if quest["id"] == quest_id:
			print("Ви вже взяли цей квест: ", quest_title)
			return
			
	var new_quest = {
		"id": quest_id,
		"title": quest_title,
		"status": "accepted"
	}
	active_quests.append(new_quest)
	print("Квест '", quest_title, "' успішно додано в журнал!")
	
	_send_quest_to_backend(quest_id)

func _send_quest_to_backend(quest_id: String):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	
	var headers = ["Content-Type: application/json"]
	
	var token = ""
	if has_node("/root/SessionManager"):
		token = get_node("/root/SessionManager").get_token() 
	
	if token != "":
		headers.append("Authorization: Bearer " + token)
		print("Токен знайдено! Додаємо в запит квесту.")
	else:
		print("Попередження: Токен не знайдено, запит до квестів піде без авторизації (може впасти помилка 401).")
	
	var body = JSON.stringify({
		"questId": quest_id,
		"status": "accepted"
	})
	
	http_request.request(QUEST_API_URL + "/accept", headers, HTTPClient.METHOD_POST, body)
	print("Синхронізація квесту з сервером...")
