extends Node2D

@onready var player_tscn = preload('res://scenes/character.tscn')

func _ready() -> void:
	print(multiplayer.multiplayer_peer)
	multiplayer.peer_connected.connect(connect_player)
	
func connect_player(id):
	add_player(id)
	
func add_player(id):
	var player = player_tscn.instantiate()
	
	player.name = str(id)
	$PlayersSpawnPoint.add_child(player)
