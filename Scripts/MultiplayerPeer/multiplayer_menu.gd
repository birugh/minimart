extends Control

@export var Adress = "127.0.0.1"
@export var port = 8910
var peer

func _ready() -> void:
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	if "--server" in OS.get_cmdline_args():
		hostGame()
		
	$ServerBrowser.joinGame.connect(joinByIp)
	pass

func _process(delta: float) -> void:
	pass

func peer_connected(id):
	print("Player connected " + str(id))

func peer_disconnected(id):
	print("Player disconnected "+str(id))
	GameManager.Player.erase(id)
	var players = get_tree().get_nodes_in_group("Player")
	for i in players:
		if i.name == str(id):
			i.queue_free()

func connected_to_server():
	print("Connected to server!")
	SendPlayerInformation.rpc_id(1, $LineEdit.text, multiplayer.get_unique_id())

func connection_failed():
	print("Couldnt server!")
	
@rpc("any_peer")
func SendPlayerInformation(name, id):
	if !GameManager.Player.has(id):
		GameManager.Player[id] ={
			"name" : name,
			"id" : id,
			"score" : 0
		}
	if multiplayer.is_server():
		for i in GameManager.Player:
			SendPlayerInformation.rpc(GameManager.Player[i].name, i)

@rpc("any_peer")
func StartGame():
	#if multiplayer.is_connected():
		#return
	print("Starting game on peer: ", multiplayer.get_unique_id())
	print("Current players: ", GameManager.Player)
	#var scene = load("res://cutscene/cutscene_intro.tscn").instantiate()
	var scene = load("res://gameplay/gameplay.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()

func hostGame():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 2)
	if error != OK:
		print("Cannot host" + str(error))
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting for player")

func _on_host_button_down() -> void:
	hostGame()
	SendPlayerInformation($LineEdit.text, multiplayer.get_unique_id())
	$ServerBrowser.setUpBroadCast($LineEdit.text + "'s server")
	pass # Replace with function body.


func _on_join_button_down() -> void:
	joinByIp(Adress)
	pass # Replace with function body.


func joinByIp(ip):
	peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	
func _on_start_game_button_down() -> void:
	StartGame.rpc()
	StartGame()
	pass # Replace with function body.


func _on_button_button_down() -> void:
	GameManager.Players[GameManager.Players.size() + 1] = {
			"name" : "test",
			"id" : 1,	
			"score" : 0
		}
	pass # Replace with function body.
