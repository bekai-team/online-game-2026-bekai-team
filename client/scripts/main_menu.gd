extends Control

@onready var status_label = $StatusLabel
@onready var info_label = $InfoLabel
@onready var play_button = $PlayButton
@onready var logout_button = $LogoutButton
@onready var login_button = $Login
@onready var register_button = $Register

var ping_req = HTTPRequest.new()
var profile_req = HTTPRequest.new()

var port = "3001" 

func _ready():
	add_child(ping_req)
	add_child(profile_req)
	
	play_button.pressed.connect(_on_play_pressed)
	
	status_label.text = "Server: Checking..."
	ping_req.request_completed.connect(_on_ping_completed)
	ping_req.request("http://localhost:" + port + "/api/health")
	
	if SessionManager.access_token != "":
		info_label.text = "Loading profile...\n"
		profile_req.request_completed.connect(_on_profile_completed)
		var headers = ["Authorization: Bearer " + SessionManager.access_token]
		profile_req.request("http://localhost:" + port + "/api/profile", headers)
		logout_button.visible = true
		login_button.visible = false
		register_button.visible = false
	else:
		info_label.text = "Status: Guest Session"

func _on_ping_completed(result, response_code, headers, body):
	if response_code == 200:
		status_label.text = "Server: ONLINE"
		status_label.add_theme_color_override("font_color", Color.GREEN)
	else:
		status_label.text = "Server: OFFLINE (Code: " + str(response_code) + ")"
		status_label.add_theme_color_override("font_color", Color.RED)

func _on_profile_completed(result, response_code, headers, body):
	info_label.text += "Welcome, {0}\n".format([SessionManager.email])
	if response_code == 200:
		info_label.text += "Character loaded. Ready to play!"
	else:
		info_label.text += "No character found. Please create one."

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/character_editor.tscn")
