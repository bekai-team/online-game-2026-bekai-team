extends Node2D

@onready var address_input: LineEdit = $MultiplayerControl/PanelContainer/VBoxContainer/AddressInput
@onready var port_input: LineEdit = $MultiplayerControl/PanelContainer/VBoxContainer/PortInput
@onready var max_players_input: LineEdit = $MultiplayerControl/PanelContainer/VBoxContainer/MaxPlayersInput
@onready var multiplayer_control: Control = $MultiplayerControl

func _on_create_host_button_pressed() -> void:
	var port: int = port_input.text.to_int()
	var max_players: int = max_players_input.text.to_int()
	var peer = ENetMultiplayerPeer.new()
	
	peer.create_server(port, max_players)
	multiplayer.multiplayer_peer = peer
	multiplayer_control.hide()
	multiplayer.peer_connected.connect(connect_player)
	add_player(1)
	
func connect_player(id):
	add_player(id)
	
func add_player(id):
	var player = preload("res://scenes/character.tscn").instantiate()
	player.name = str(id)
	$PlayersSpawnPoint.add_child(player)
	
func _on_join_button_pressed() -> void:
	var address: String = address_input.text
	var port: int = port_input.text.to_int()
	var peer = ENetMultiplayerPeer.new()
	
	peer.create_client(address, port)
	multiplayer.multiplayer_peer = peer
	multiplayer_control.hide()
