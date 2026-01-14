extends Node2D

var scheme
var mastermind
var villains
var heros

var scheme_override = {}

var websocket_url = "ws://0.0.0.0:8080"
var socket = WebSocketPeer.new()
var host

var gameStarted = false

var playerCount = 1
var username
var heroShuffleCode
var villainShuffleCode

var turn

var gNode

var connected = false

signal heroShuffleCodeRecieved
signal villainShuffleCodeRecieved
signal firstTurnRecieved
signal setupCodeReceived
signal connectedSignal

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		socket.close()
		get_tree().quit() # default behavior

# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		socket.close()
		get_tree().quit()

func connectMultiplayer():
	var err = socket.connect_to_url(websocket_url)
	if err == OK:
		connected = true
		print("Connecting to %s..." % websocket_url)
		# Wait for the socket to connect.
		await get_tree().create_timer(.2).timeout

		# Send data.
		#print("> Sending test packet.")
		socket.send_text("ping")
		await connectedSignal
		
	else:
		push_error("Unable to connect.")
		set_process(false)

func _ready() -> void:
	get_tree().set_auto_accept_quit(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	# Call this in `_process()` or `_physics_process()`.
	# Data transfer and state updates will only happen when calling this function.
	if connected:
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
					if packet_text == "Pong":
						emit_signal("connectedSignal")
						socket.send_text(str("Uname:", username))
					elif packet_text.begins_with("PlayerCount:"):
						playerCount = int(packet_text[-1])
						startGame()
					elif packet_text.begins_with("HeroDeck:"):
						#print("Got hero deck")
						var codeStr = packet_text.substr(9, packet_text.length())
						codeStr = JSON.parse_string(codeStr)
						for i in range(codeStr.size()):
							codeStr[i] = int(codeStr[i])
						heroShuffleCode = codeStr
						emit_signal("heroShuffleCodeRecieved")
					elif packet_text.begins_with("VillainDeck:"):
						#print("Got villain deck")
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
					elif packet_text.begins_with("Recruited:"):
						var f = int(packet_text.substr(10, packet_text.length()))
						if f == -1:
							gNode.get_node("HQ").addOfficer(true)
						else:
							gNode.get_node("HQ").removeHero(f)
					elif packet_text.begins_with("Fought:"):
						var f = int(packet_text.substr(7, packet_text.length()))
						gNode.get_node("City").removeVil(f)
					elif packet_text.begins_with("Tactic:"):
						#print("Tactic received : ", packet_text)
						var f = int(packet_text.substr(7, packet_text.length()))
						gNode.get_node("Mastermind").removeTactic(f)
					elif packet_text.begins_with("Wound"):
						gNode.get_node("Wounds").draw(false)
					elif packet_text.begins_with("CardEffect:"):
						var eff = packet_text.substr(11, packet_text.length())
						var cName = eff.substr(0, eff.find(":"))
						var choice = eff.substr(eff.find(":") + 1, -1)
						await gNode.get_node("EffectManager").aop_effects[cName].call(choice)
					elif packet_text.begins_with("SetupCode:"):
						var codeStr = packet_text.substr(10, packet_text.length())
						codeStr = JSON.parse_string(codeStr)
						for i in range(codeStr.size()):
							codeStr[i] = int(codeStr[i])
						setup(codeStr)
					elif packet_text.begins_with("Lobby:"):
						var lText = packet_text.substr(6, -1)
						$MemberLabel.text = lText
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
	$JoinButton.visible = false
	$HostButton.visible = false
	$BackButton.visible = false
	$StartButton.visible = true
	$MemberLabel.text = username
	host = true
	#username = "host"
	socket.send_text("Create Lobby")
	$StartButton.visible = true

# Join Button
func _on_button_button_down() -> void:
	$JoinButton.visible = false
	$HostButton.visible = false
	$BackButton.visible = false
	$LeaveButton.visible = true
	host = false
	#username = "joiner"
	socket.send_text("Join Lobby")

# Start Button
func _on_start_button_button_down() -> void:
	socket.send_text("Start Game")

# Single player button
func _on_single_button_button_down() -> void:
	if $Username.text == "":
		return
	username = $Username.text
	host = true
	playerCount = 1
	turn = username
	startGame()

func startGame():
	$JoinButton.visible = false
	$HostButton.visible = false
	$StartButton.visible = false
	$SingleButton.visible = false
	$MultiplayerButton.visible = false
	$LeaveButton.visible = false
	$BackButton.visible = false
	$Username.visible = false
	
	if not host:
		if not scheme:
			await setupCodeReceived
		if not heroShuffleCode:
			#print("Waiting hero")
			await heroShuffleCodeRecieved
		if not villainShuffleCode:
			#print("Waiting villain")
			await villainShuffleCodeRecieved
	else:
		setup()
		
	if not turn:
		#print("No turn")
		await firstTurnRecieved
	var game = preload("res://Scenes/Game.tscn")
	gNode = game.instantiate()
	add_child(gNode)
	gameStarted = true
	gNode.start()

func generateChoices(amount, limit, c = []):
	if amount > limit:
		print("Unable to gen choices: ", amount, " limit ", limit)
	while c.size() < amount:
		var n = randi_range(0, limit-1)
		while n in c:
			n = randi_range(0, limit-1)
		c.append(n)
	return c

func setup(c = null):
	var vilCount
	var henchCount
	var heroCount = 5
	match playerCount:
		1:
			vilCount = 1
			henchCount = 1
			heroCount = 3
		2:
			vilCount = 2
			henchCount = 1
		3:
			vilCount = 3
			henchCount = 1
		4:
			vilCount = 3
			henchCount = 2
		5:
			vilCount = 4
			henchCount = 2
			heroCount = 6
	
	# Scheme, Mastermind, Vils, Henchmen, Heros
	if not c:
		# GameData.BASE_VILLAINS.find(GameData.BROTHERHOOD_VILLAINS)
		# GameData.BASE_HENCHMEN.find(GameData.HENCHMAN_DOOMBOTLEGION)
		var hench = []
		var vils = []
		var code = []
		var hlist = []
		var snum = generateChoices(1, GameData.BASE_SCHEMES.size())
		if playerCount == 1:
			while !GameData.BASE_SCHEMES[snum[0]].solo:
				snum = generateChoices(1, GameData.BASE_SCHEMES.size())
		code.append_array(snum)
		var tempS = GameData.BASE_SCHEMES[code[0]]
		if tempS.sName == "Negative Zone Prison Breakout":
			henchCount += 1
		code.append_array(generateChoices(1, GameData.BASE_MASTERMINDS.size()))
		var mmind = GameData.BASE_MASTERMINDS[code[1]]
		var leads = mmind.leads
		
		if playerCount > 1:
		# is henchman
			if "team" in leads.keys():
				hench.append(GameData.BASE_HENCHMEN.find(mmind.leads))
			else:
				vils.append(GameData.BASE_VILLAINS.find(mmind.leads))

		code.append_array(generateChoices(vilCount, GameData.BASE_VILLAINS.size(), vils))
		code.append_array(generateChoices(henchCount, GameData.BASE_HENCHMEN.size(), hench))
		code.append_array(generateChoices(heroCount, GameData.BASE_HEROS.size(), hlist))
		
		if playerCount > 1:
			socket.send_text(str("SetupCode:", JSON.stringify(code)))
		setup(code)
	else:
		#print("Received code ", c)
		scheme = GameData.BASE_SCHEMES[c.pop_front()]
		
		if scheme.sName == "Negative Zone Prison Breakout":
			henchCount += 1
			
		mastermind = GameData.BASE_MASTERMINDS[c.pop_front()]
		for i in range(vilCount):
			if i == 0:
				villains = []
			villains.append(GameData.BASE_VILLAINS[c.pop_front()])
		for i in range(henchCount):
			villains.append(GameData.BASE_HENCHMEN[c.pop_front()])
		
		for i in range(heroCount):
			if i == 0:
				heros = []
			heros.append(GameData.BASE_HEROS.keys()[c.pop_front()])
		#print(c)
		assert(c.size() == 0, "Code is invalid")
		emit_signal("setupCodeReceived")


func _on_multiplayer_button_button_down() -> void:
	if $Username.text == "":
		return
	username = $Username.text
	connectMultiplayer()
	$SingleButton.visible = false
	$MultiplayerButton.visible = false
	$HostButton.visible = true
	$JoinButton.visible = true
	$BackButton.visible = true
	$Username.editable = false


func _on_back_button_button_down() -> void:
	connected = false
	socket.close()
	$SingleButton.visible = true
	$MultiplayerButton.visible = true
	$HostButton.visible = false
	$JoinButton.visible = false
	$BackButton.visible = false
	$Username.editable = true
