extends Control

signal found_server(ip, port, roomInfo)
signal update_server(ip, port, roomInfo)
#signal server_removed
signal joinGame(ip)

var broadcastTimer : Timer

var RoomInfo = {"name":"name", "playerCount": 0}
var broadcaster : PacketPeerUDP
var listener : PacketPeerUDP
@export var listenPort : int = 8911
@export var broadcastPort : int = 8912
@export var broadcastAddress : String = '192.168.1.255'
@export var serverInfo : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	broadcastTimer = $BroadcastTimer
	setUp()
	pass # Replace with function body.

func setUp():
	listener = PacketPeerUDP.new()
	var ok = listener.bind(listenPort)
	
	if ok == OK:
		print("Bound to listen Port " + str(listenPort) + "Successful")
		$Label2.text = "Bound to Listen Port: true"
	else:
		print("Failed to bind to listen port")
		$Label2.text = "Bound to Listen Port: false"

func setUpBroadCast(name):
	RoomInfo.name = name
	RoomInfo.playerCount = GameManager.Player.size()
	
	broadcaster = PacketPeerUDP.new()
	broadcaster.set_broadcast_enabled(true)
	broadcaster.set_dest_address(broadcastAddress, listenPort)

	var ok = broadcaster.bind(broadcastPort)
	
	if ok == OK:
		print("Bound to Broadcast Port " + str(broadcastPort) + "Successful")
	else:
		print("Failed to bind to broadcast port")
		
		
	broadcastTimer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if listener.get_available_packet_count() > 0:
		var serverip = listener.get_packet_ip()
		var serverport = listener.get_packet_port()
		var bytes = listener.get_packet()
		var data = bytes.get_string_from_ascii()
		var roomInfo = JSON.parse_string(data)
		
		print("Server IP: " + serverip + " Server Port: " + str(serverport) + " room info: " + str(roomInfo))
		
		for i in $Panel/VBoxContainer.get_children():
			if i.name == roomInfo.name:
				update_server.emit(serverip, serverport, roomInfo)
				i.get_node("Ip").text = serverip
				i.get_node("PlayerCount").text = str(roomInfo.playerCount)
				return
		var child = $Panel/VBoxContainer.find_child(roomInfo.name)
		if child != null:
			child.get_node("Ip").text = serverip
			child.get_node("PlayerCount").text = str(roomInfo.playerCount)
			
		else:
			var currentInfo = serverInfo.instantiate()
			currentInfo.name = roomInfo.name
			currentInfo.get_node("Name").text = roomInfo.name
			currentInfo.get_node("Ip").text = serverip
			currentInfo.get_node("PlayerCount").text = str(roomInfo.playerCount)
			$Panel/VBoxContainer.add_child(currentInfo)
			#$ServerBrowser.joinGame.connect(joinByIp)
			currentInfo.joinGame.connect(joinByIp)
			found_server.emit(serverip, serverport, roomInfo)
			pass
	pass


func _on_broadcast_timer_timeout() -> void:
	print("Broadcasting game!")
	RoomInfo.playerCount = GameManager.Player.size()
	var data = JSON.stringify(RoomInfo)
	var packet = data.to_ascii_buffer()
	broadcaster.put_packet(packet)
	pass # Replace with function body.

func cleanUp():
	listener.close()
	broadcastTimer.stop()
	if broadcaster != null:
		broadcaster.close()

func _exit_tree():
	cleanUp()

func joinByIp(ip):
	joinGame.emit(ip)
