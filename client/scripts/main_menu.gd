extends Control

var ping_req = HTTPRequest.new()
var profile_req = HTTPRequest.new()

func _ready():
	var status_label = Label.new()
	status_label.position = Vector2(15, 15)
	status_label.text = "Server: Checking..."
	add_child(status_label)
	
	var info_label = Label.new()
	info_label.position = Vector2(15, 45) 
	add_child(info_label)
	
	add_child(ping_req)
	add_child(profile_req)
	
	ping_req.request_completed.connect(func(res, code, hdr, body):
		if code == 200:
			status_label.text = "Server: ONLINE"
			status_label.add_theme_color_override("font_color", Color.GREEN)
		else:
			status_label.text = "Server: OFFLINE"
			status_label.add_theme_color_override("font_color", Color.RED)
	)
	ping_req.request("http://localhost:3000/api/health") 
	
	if SessionManager.access_token != "":
		info_label.text = "Loading profile..."
		profile_req.request_completed.connect(func(res, code, hdr, body):
			if code == 200:
				info_label.text = "Character found. Ready to play!"
			else:
				info_label.text = "No character found. Need to create one."
		)
		var headers = ["Authorization: Bearer " + SessionManager.access_token]
		profile_req.request("http://localhost:3000/api/profile", headers)
