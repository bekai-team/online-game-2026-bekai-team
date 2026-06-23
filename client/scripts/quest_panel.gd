extends CanvasLayer 

@onready var quest_list = %QuestList
@onready var quest_title = %QuestTitle
@onready var quest_desc = %QuestDesc
@onready var close_btn = %CloseBtn

func _ready():
	hide() 
	
	close_btn.pressed.connect(_on_close_pressed)
	quest_list.item_selected.connect(_on_quest_selected)
	
	_update_quest_list()

func _update_quest_list():
	quest_list.clear() 
	
	match Global.quest_state:
		0:
			quest_list.add_item("Немає активних завдань")
		1:
			quest_list.add_item("[ ! ] Зачистка щурів")
		2:
			quest_list.add_item("[ ? ] Зачистка щурів (Готово)")
		3:
			quest_list.add_item("[ v ] Зачистка щурів (Здано)")
			
	quest_list.select(0)
	_on_quest_selected(0)

func _on_quest_selected(_index: int):
	match Global.quest_state:
		0:
			quest_title.text = "Вільно"
			quest_desc.text = "Поговоріть з мешканцями Хабу, щоб знайти роботу."
		1:
			quest_title.text = "Зачистка щурів"
			quest_desc.text = "Хлопчик попросив зачистити підвал від щурів.\n\nПрогрес: Вбито щурів " + str(Global.rats_killed) + " / " + str(Global.rats_required)
		2:
			quest_title.text = "Зачистка щурів"
			quest_desc.text = "Ви успішно знищили всіх щурів!\n\nПовертайтеся до хлопчика в Хаб за нагородою."
		3:
			quest_title.text = "Зачистка щурів"
			quest_desc.text = "Квест успішно завершено. Ви допомогли Хабу і отримали нагороду!"

func _on_close_pressed():
	hide()

func _input(event):
	if event.is_action_pressed("toggle_quests"):

		var dialogue = get_tree().current_scene.find_child("DialoguePanel", true, false)
		
		if dialogue and dialogue.visible:
			return 
		
		visible = !visible
		if visible:
			_update_quest_list()
