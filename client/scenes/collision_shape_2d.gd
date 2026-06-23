extends Area2D

@onready var dialogue_panel = %DialoguePanel
@onready var dialogue_input = dialogue_panel.find_child("DialogueInput", true, false)
@onready var output_label = dialogue_panel.find_child("OutputLabel", true, false)
@onready var accept_btn = dialogue_panel.find_child("AcceptButton", true, false)
@onready var decline_btn = dialogue_panel.find_child("DeclineButton", true, false)
@onready var f_label = $F_Label
@onready var player = get_parent().get_node("Character")
var player_in_zone = false
static var is_talking: bool = false

func _ready():
	f_label.hide()
	dialogue_panel.hide()
	accept_btn.pressed.connect(_on_accept_pressed)
	decline_btn.pressed.connect(_on_decline_pressed)
	dialogue_panel.message_sent.connect(_on_player_typed)

func _process(_delta):
	if is_instance_valid(player):
		var distance = global_position.distance_to(player.global_position)
		if distance < 60.0:
			if not player_in_zone:
				player_in_zone = true
				f_label.show()
		else:
			if player_in_zone:
				player_in_zone = false
				f_label.hide()
				dialogue_panel.hide()
				player.set_physics_process(true)

	if player_in_zone and Input.is_action_just_pressed("interact") and not dialogue_panel.visible:
		talk_to_npc()

func talk_to_npc():
	is_talking = true
	player.set_physics_process(false)
	f_label.hide()
	dialogue_panel.show()
	
	match Global.quest_state:
		0:
			output_label.text = "Допоможи! Знизу повно щурів. Вбий 3 штуки."
			accept_btn.text = "Прийняти"
			decline_btn.text = "Відмовитись"
			accept_btn.show()
			decline_btn.show()
		1:
			output_label.text = "Ти ще не вбив усіх щурів! Залишилося: " + str(Global.rats_required - Global.rats_killed)
			accept_btn.text = "Добре, йду"
			decline_btn.hide()
		2:
			output_label.text = "Ого, ти їх знищив! Дякую. Ось твоя нагорода."
			accept_btn.text = "Здати квест"
			decline_btn.hide()
		3:
			output_label.text = "Дякую за допомогу, тепер тут безпечно."
			accept_btn.text = "Бувай"
			decline_btn.hide()

func _on_accept_pressed():
	if Global.quest_state == 0:
		Global.quest_state = 1
		Global.rats_killed = 0
		var notification = get_parent().get_node("UILayer/QuestNotification")
		notification.show_message("Натисніть Q, щоб переглянути квест")
		
	elif Global.quest_state == 2:
		Global.quest_state = 3
		var end_scene_path = "res://scenes/end_screen.tscn" 
		if ResourceLoader.exists(end_scene_path):
			var end_scene = load(end_scene_path).instantiate()
			get_tree().root.add_child(end_scene) 
		else:
			print("ПОМИЛКА: Не знайдено сцену за шляхом: ", end_scene_path)
	
	player.set_physics_process(true)
	dialogue_panel.hide()
	if player_in_zone: f_label.show()

func _on_decline_pressed():
	is_talking = false
	player.set_physics_process(true)
	dialogue_panel.hide()
	if player_in_zone: f_label.show()
	
func _on_player_typed(text: String):
	var lower_text = text.to_lower()
	dialogue_input.text = "" 
	
	if lower_text.contains("вбит") or lower_text.contains("щур"):
		output_label.text = "NPC: Знайди зброю (дробовик) або бий їх впритул мишкою!"
	elif lower_text.contains("порад") or lower_text.contains("виконат"):
		output_label.text = "NPC: Бийся по одному. Не дай себе оточити!"
	else:
		output_label.text = "NPC: Я не розумію. Запитай як 'вбити щурів' або дай 'пораду'."
