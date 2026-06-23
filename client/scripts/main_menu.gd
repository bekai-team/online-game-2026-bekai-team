extends Control

@onready var status_label = $StatusLabel
@onready var info_label = $InfoLabel
@onready var play_button = $PlayButton
@onready var logout_button = $LogoutButton
@onready var login_button = $Login
@onready var register_button = $Register

var ping_req = HTTPRequest.new()
var port = "3000" 

func _ready():
	add_child(ping_req)
	play_button.pressed.connect(_on_play_pressed)
	
	status_label.text = "Server: Checking..."
	ping_req.request_completed.connect(_on_ping_completed)
	ping_req.request("http://localhost:" + port + "/api/health")
	
	if SessionManager.access_token != "":
		info_label.text = "Loading profile...\n"
		var headers = ["Authorization: Bearer " + SessionManager.access_token]
		logout_button.visible = true
		login_button.visible = false
		register_button.visible = false
		info_label.text += "Welcome, {0}\n".format([SessionManager.email])
	else:
		info_label.text = "Status: Guest Session"

func _on_ping_completed(result, response_code, headers, body):
	if response_code == 200:
		status_label.text = "Server: ONLINE"
		status_label.add_theme_color_override("font_color", Color.GREEN)
	else:
		status_label.text = "Server: OFFLINE (Code: " + str(response_code) + ")"
		status_label.add_theme_color_override("font_color", Color.RED)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/character_editor.tscn")
