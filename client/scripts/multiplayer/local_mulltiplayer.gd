extends Control

@onready var address_input: LineEdit = $PanelContainer/VBoxContainer/AddressInput
@onready var port_input: LineEdit = $PanelContainer/VBoxContainer/PortInput
@onready var max_players_input: LineEdit = $PanelContainer/VBoxContainer/MaxPlayersInput

func _on_create_host_button_pressed() -> void:
	var port: int = port_input.text.to_int()
	var max_players: int = max_players_input.text.to_int()
	var peer = ENetMultiplayerPeer.new()
	
	peer.create_server(port, max_players)
	multiplayer.multiplayer_peer = peer
	get_tree().change_scene_to_file("res://scenes/world_multiplayer.tscn")

func _on_join_button_pressed() -> void:
	var address: String = address_input.text
	var port: int = port_input.text.to_int()
	var peer = ENetMultiplayerPeer.new()
	
	peer.create_client(address, port)
	multiplayer.multiplayer_peer = peer
	print(multiplayer.multiplayer_peer)
	
	get_tree().change_scene_to_file("res://scenes/world_multiplayer.tscn")
