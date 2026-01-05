extends Node2D

var websocket_url = "ws://localhost:9080"
var socket = WebSocketPeer.new()
var host

var gameStarted = false

var playerCount = 1
var username
var heroShuffleCode
var villainShuffleCode

var turn

var gNode

signal heroShuffleCodeRecieved
signal villainShuffleCodeRecieved
signal firstTurnRecieved

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		socket.close()
		get_tree().quit() # default behavior

# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		socket.close()
		get_tree().quit()

func _ready() -> void:
	get_tree().set_auto_accept_quit(false)
	# Initiate connection to the given URL.
	var err = socket.connect_to_url(websocket_url)
	if err == OK:
		print("Connecting to %s..." % websocket_url)
		# Wait for the socket to connect.
		await get_tree().create_timer(1).timeout

		# Send data.
		print("> Sending test packet.")
		socket.send_text("ping")
	else:
		push_error("Unable to connect.")
		set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	# Call this in `_process()` or `_physics_process()`.
	# Data transfer and state updates will only happen when calling this function.
	socket.poll()

	# get_ready_state() tells you what state the socket is in.
	var state = socket.get_ready_state()

	# `WebSocketPeer.STATE_OPEN` means the socket is connected and ready
	# to send and receive data.
	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			var packet = socket.get_packet()
			if socket.was_string_packet():
				var packet_text = packet.get_string_from_utf8()
				if packet_text == "pong":
					print("Setup")
				elif packet_text.begins_with("PlayerCount:"):
					playerCount = int(packet_text[-1])
					startGame()
				elif packet_text.begins_with("HeroDeck:"):
					var codeStr = packet_text.substr(9, packet_text.length())
					codeStr = JSON.parse_string(codeStr)
					for i in range(codeStr.size()):
						codeStr[i] = int(codeStr[i])
					heroShuffleCode = codeStr
					emit_signal("heroShuffleCodeRecieved")
				elif packet_text.begins_with("VillainDeck:"):
					var codeStr = packet_text.substr(12, packet_text.length())
					codeStr = JSON.parse_string(codeStr)
					for i in range(codeStr.size()):
						codeStr[i] = int(codeStr[i])
					villainShuffleCode = codeStr
					emit_signal("villainShuffleCodeRecieved")
				elif packet_text.begins_with("Turn:"):
					turn = packet_text.substr(5, packet_text.length())
					if gameStarted:
						gNode.newTurn()
					else:
						emit_signal("firstTurnRecieved")
				elif host:
					print("Host: ", packet_text)
				else:
					print("Member: ", packet_text)
			else:
				print("< Got binary data from server: %d bytes" % packet.size())

	# `WebSocketPeer.STATE_CLOSING` means the socket is closing.
	# It is important to keep polling for a clean close.
	elif state == WebSocketPeer.STATE_CLOSING:
		pass

	# `WebSocketPeer.STATE_CLOSED` means the connection has fully closed.
	# It is now safe to stop polling.
	elif state == WebSocketPeer.STATE_CLOSED:
		# The code will be `-1` if the disconnection was not properly notified by the remote peer.
		var code = socket.get_close_code()
		print("WebSocket closed with code: %d. Clean: %s" % [code, code != -1])
		set_process(false) # Stop processing.

# Host button
func _on_host_button_button_down() -> void:
	$SingleButton.visible = false
	host = true
	username = "host"
	socket.send_text("Create Lobby")
	$StartButton.visible = true

# Join Button
func _on_button_button_down() -> void:
	$SingleButton.visible = false
	host = false
	username = "joiner"
	socket.send_text("Join Lobby")

# Start Button
func _on_start_button_button_down() -> void:
	socket.send_text("Start Game")

# Single player button
func _on_single_button_button_down() -> void:
	username = ""
	host = true
	playerCount = 1
	turn = username
	startGame()

func startGame():
	$JoinButton.visible = false
	$HostButton.visible = false
	$StartButton.visible = false
	$SingleButton.visible = false
	
	if not host:
		if not heroShuffleCode:
			await heroShuffleCodeRecieved
		if not villainShuffleCode:
			await villainShuffleCodeRecieved
	if not turn:
		await firstTurnRecieved
	var game = preload("res://Scenes/Game.tscn")
	gNode = game.instantiate()
	add_child(gNode)
	gameStarted = true
	gNode.start()
