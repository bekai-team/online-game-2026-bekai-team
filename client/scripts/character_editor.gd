extends Control

@onready var start_btn = %StartButton
@onready var character = %Character

@onready var clothes_sprite = character.get_node("Skeleton/Upper/Sprite")
@onready var body_sprite = character.get_node("Skeleton/Body/Sprite")

@onready var clothes_btn = %ClothesBtn
@onready var skin_btn = %SkinBtn
@onready var right_col = %RightCol

var clothes_colors = {
	"Y2K Frost": Color(0.8, 0.9, 1.0),
	"Underworld Crimson": Color(0.4, 0.0, 0.1),
	"Void Black": Color(0.1, 0.1, 0.1)
}

var skin_tones = {
	"Cold Pale": Color(0.95, 0.9, 0.92),
	"Natural": Color(0.85, 0.7, 0.6),
	"Ashes": Color(0.6, 0.55, 0.55)
}

var stats = [5, 5, 5, 5, 5, 5, 5]
var http_request = HTTPRequest.new()

func _ready():
	character.set_physics_process(false)
	character.set_process_unhandled_input(false)
	
	_setup_dropdown(clothes_btn, clothes_colors.keys(), _on_clothes_selected)
	_setup_dropdown(skin_btn, skin_tones.keys(), _on_skin_selected)

	for i in range(right_col.get_child_count()):
		var row = right_col.get_child(i)
		if row is HBoxContainer:
			var minus_btn = row.get_node("MinusBtn")
			var plus_btn = row.get_node("PlusBtn")
			var value_label = row.get_node("StatValue")
			
			minus_btn.pressed.connect(_change_stat.bind(i, -1, value_label))
			plus_btn.pressed.connect(_change_stat.bind(i, 1, value_label))
			
	start_btn.pressed.connect(_on_start_pressed)
	
	add_child(http_request)
	http_request.request_completed.connect(_on_save_completed)

func _setup_dropdown(btn: OptionButton, items: Array, callable: Callable):
	btn.clear()
	for item in items:
		btn.add_item(item)
	btn.item_selected.connect(callable)
	callable.call(0)

func _on_clothes_selected(index: int):
	var color_name = clothes_colors.keys()[index]
	clothes_sprite.modulate = clothes_colors[color_name]

func _on_skin_selected(index: int):
	var color_name = skin_tones.keys()[index]
	body_sprite.modulate = skin_tones[color_name]

func _change_stat(index: int, amount: int, label: Label):
	stats[index] = clamp(stats[index] + amount, 1, 10)
	label.text = str(stats[index])

func _on_start_pressed():
	start_btn.text = "Saving..."
	
	var data = {
		"stats": stats,
		"clothes_color": clothes_sprite.modulate.to_html(),
		"skin_color": body_sprite.modulate.to_html()
	}
	var json_data = JSON.stringify(data)
	var headers = [
		"Content-Type: application/json",
		"Authorization: Bearer " + SessionManager.access_token
	]
	
	var create_url = "http://localhost:3000/api/character" 
	#http_request.request(create_url, headers, HTTPClient.METHOD_POST, json_data)
	Global.player_clothes_color = clothes_sprite.modulate
	Global.player_skin_color = body_sprite.modulate
	Engine.get_main_loop().change_scene_to_file('res://scenes/hub.tscn')

func _on_save_completed(result, response_code, headers, body):
	if response_code == 200 or response_code == 201:
		Global.player_clothes_color = clothes_sprite.modulate
		Global.player_skin_color = body_sprite.modulate
		get_tree().change_scene_to_file("res://scenes/hub.tscn")
	else:
		start_btn.text = "Error! " + str(response_code)
		
	#Global.player_clothes_color = clothes_sprite.modulate
	#Global.player_skin_color = body_sprite.modulate
	#get_tree().change_scene_to_file("res://scenes/hub.tscn")
