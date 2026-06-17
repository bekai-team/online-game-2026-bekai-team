extends CanvasLayer

@onready var quest_list = %QuestList
@onready var quest_title = %QuestTitle
@onready var quest_desc = %QuestDesc
@onready var close_btn = %CloseBtn

# Тимчасова локальна база квестів для тестування UI
var quests = [
	{
		"title": "Перші кроки",
		"desc": "Світ Maditron не пробачає помилок.\n\nЗавдання: Знайди вихід із початкового сектора.\n\nНагорода: 100 XP",
		"status": "активний"
	},
	{
		"title": "Зниклий код",
		"desc": "Артем загубив флешку з ключами доступу до бази даних. Можливо, вона десь біля старих серверів.\n\nЗавдання: Знайти флешку.\n\nНагорода: Унікальний скін",
		"status": "активний"
	}
]

func _ready():
	hide() # Вікно має бути закритим при старті гри
	
	# Підключаємо сигнали через код (щоб не клацати в редакторі)
	close_btn.pressed.connect(_on_close_pressed)
	quest_list.item_selected.connect(_on_quest_selected)
	
	# Очищуємо тексти за замовчуванням
	quest_title.text = "Оберіть завдання"
	quest_desc.text = ""
	
	_update_quest_list()

func _update_quest_list():
	quest_list.clear()
	for quest in quests:
		var display_text = ""
		if quest["status"] == "активний":
			display_text = "[ ! ] " + quest["title"]
		else:
			display_text = "[ v ] " + quest["title"]
			
		quest_list.add_item(display_text)

func _on_quest_selected(index: int):
	var selected_quest = quests[index]
	quest_title.text = selected_quest["title"]
	quest_desc.text = selected_quest["desc"]

func _on_close_pressed():
	hide()

# Відкриття/закриття вікна на кнопку (клавіша 'Q')
func _input(event):
	if event.is_action_pressed("toggle_quests"): # Налаштуємо цю кнопку нижче
		visible = !visible
		if visible:
			_update_quest_list()
