extends Node2D

'''
A = Autoplay
D = Discard
V = Vicpile
P = Played
K = KO Pile
I = Info
T = Tactic
S = Escape
W = Debug (in Player hnad)
'''

var isFocused = false

var seeingDeck = null

var cardDragged
var draggedZ

var autoplaying = false

var screenSize
var isHovering
var cardHovering

var cardZoomed
var oldZoomPos
var oldZoomZ

const BASE_SIZE = .5
const HIGHLIGHT_SIZE = .75
const PLAY_ZONE = 400
const ZOOM_SCALE = 2

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if (event is InputEventKey and event.keycode == KEY_SPACE and !event.is_echo()) or (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MIDDLE):
		if event.is_pressed() and !cardDragged and !cardZoomed:
			var c = findCard()
			if c and c.isZoomable and !c.isMoving and (!autoplaying or c not in $"../PlayerHand".playerHand):
				cardZoomed = c
				oldZoomPos = c.position
				oldZoomZ = c.z_index
				c.position = Vector2(screenSize.x / 2.0, screenSize.y / 2.0)
				c.scale = Vector2(ZOOM_SCALE, ZOOM_SCALE)
				c.z_index = 100
				$"../ExtraLabels".showLabel(c.getExtraText())
		elif event.is_released() and cardZoomed:
			unzoomCard()
			#cardZoomed.position = oldZoomPos
			#cardZoomed.scale = Vector2(BASE_SIZE, BASE_SIZE)
			#cardZoomed.z_index = oldZoomZ
			#hoverOff(cardZoomed)
			#$"../ExtraLabels".removeLabel()
			#cardZoomed = null
	# DEBUG
	if event is InputEventKey and event.keycode == KEY_N and !event.is_echo() and event.is_pressed():
		var c = findCard(false)
		if c:
			c = c[0]
			print(c)
			if c.identifier == "Villain":
				print(c.bystanders)

	if $"../BlackScreen".isCovered and seeingDeck == null:
		return
	if isFocused:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and !cardZoomed:
		if event.is_pressed():
			var c = findCard()
			if c and $"../PlayerHand".isCardInHand(c) and $"..".yourTurn:
				draggedZ = c.z_index
				c.z_index = 50
				cardDragged = c
		elif cardDragged:
			if cardDragged.position.y < PLAY_ZONE and cardDragged.identifier == "Hero":
				$"../PlayerHand".playCard(cardDragged)
			elif $"../PlayerHand".isCardInHand(cardDragged):
				$"../PlayerHand".animateCard(cardDragged, cardDragged.handPos)
			cardDragged.z_index = draggedZ
			cardDragged = null
	if cardDragged:
		return
	if event is InputEventKey and event.keycode == KEY_SLASH and !event.is_echo():
		if event.is_pressed() and !seeingDeck:
			$"../BlackScreen".showControls()
			seeingDeck = "/"
		elif seeingDeck == "/":
			$"../BlackScreen".stopShowControls()
			seeingDeck = null
	if event is InputEventKey and event.keycode == KEY_D and !event.is_echo():
		if event.is_pressed() and !seeingDeck:
			$"../BlackScreen".showCards($"../PlayerHand".deck.discard, false)
			seeingDeck = "D"
		elif seeingDeck == "D":
			$"../BlackScreen".stopShowCards()
			seeingDeck = null
	if event is InputEventKey and event.keycode == KEY_V and !event.is_echo():
		if event.is_pressed() and !seeingDeck:
			$"../BlackScreen".showCards($"../PlayerHand".vicPile, false)
			seeingDeck = "V"
		elif seeingDeck == "V":
			$"../BlackScreen".stopShowCards()
			seeingDeck = null
	if event is InputEventKey and event.keycode == KEY_P and !event.is_echo():
		if event.is_pressed() and !seeingDeck:
			$"../BlackScreen".showCards($"../PlayerHand".played, false)
			seeingDeck = "P"
		elif seeingDeck == "P":
			$"../BlackScreen".stopShowCards()
			seeingDeck = null
	if event is InputEventKey and event.keycode == KEY_K and !event.is_echo():
		if event.is_pressed() and !seeingDeck:
			$"../BlackScreen".showCards($"../KODeck".cards, false)
			seeingDeck = "K"
		elif seeingDeck == "K":
			$"../BlackScreen".stopShowCards()
			seeingDeck = null
	if event is InputEventKey and event.keycode == KEY_I and !event.is_echo():
		if event.is_pressed() and !seeingDeck:
			$"../BlackScreen".showInfoPanel()
			seeingDeck = "I"
		elif seeingDeck == "I":
			$"../BlackScreen".stopShowInfoPanel()
			seeingDeck = null
	if event is InputEventKey and event.keycode == KEY_T and !event.is_echo():
		if event.is_pressed() and !seeingDeck:
			$"../BlackScreen".showCards($"../Mastermind".tactics, false)
			seeingDeck = "T"
		elif seeingDeck == "T":
			$"../BlackScreen".stopShowCards()
			seeingDeck = null
	if event is InputEventKey and event.keycode == KEY_S and !event.is_echo():
		if event.is_pressed() and !seeingDeck:
			$"../BlackScreen".showCards($"../EscapePile".cards, false)
			seeingDeck = "S"
		elif seeingDeck == "S":
			$"../BlackScreen".stopShowCards()
			seeingDeck = null
	if event is InputEventKey and event.keycode == KEY_A and !event.is_echo() and $"..".yourTurn:
		if event.is_pressed():
			isHovering = false
			cardHovering = null
			autoplaying = true
			unzoomCard()
			await $"../PlayerHand".autoplay()
			autoplaying = false
	if event is InputEventKey and event.keycode == KEY_E and !event.is_echo() and $"..".yourTurn:
		if event.is_pressed() and !seeingDeck:
			$"../PlayerHand"._on_button_button_down()

	

func unzoomCard():
	if cardZoomed:
		#$"../PlayerHand".animateCard(cardZoomed, oldZoomPos)
		#$"../PlayerHand".animateZ(cardZoomed, oldZoomZ)
		cardZoomed.position = oldZoomPos
		cardZoomed.scale = Vector2(BASE_SIZE, BASE_SIZE)
		cardZoomed.z_index = oldZoomZ
		#hoverOff(cardZoomed)
		$"../ExtraLabels".removeLabel()
		cardZoomed = null

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_WINDOW_FOCUS_OUT:
		unzoomCard()
		if seeingDeck and seeingDeck != "I":
			$"../BlackScreen".stopShowCards()
		elif seeingDeck == "I":
			$"../BlackScreen".stopShowInfoPanel()
		seeingDeck = null

func findCard(first=true):
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = 1
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		if !first:
			var ret = []
			for i in result:
				ret.append(i.collider.get_parent())
			return ret
		var topCard = result[0].collider.get_parent()
		for i in range(1, result.size()):
			if result[i].collider.get_parent().z_index > topCard.z_index:
				topCard = result[i].collider.get_parent()
		return topCard
	return null

#func hoverOn(card):
	#return
	#if !isHovering and !cardZoomed and !isFocused and card in $"../PlayerHand".playerHand and !card.isMoving:
		#highlightCard(card, true)
		#cardHovering = card
		#isHovering = true

#func hoverOff(card):
	#return
	##print("HoverOff")
	#if cardZoomed:
		#return
	#highlightCard(card, false)
	##isHovering = false
	#var newCard = findCard()
	#if newCard and !isHovering and !cardZoomed and !isFocused and newCard in $"../PlayerHand".playerHand and !newCard.isMoving:
		#highlightCard(newCard, true)
	#else:
		#isHovering = false

@warning_ignore("unused_parameter")
func highlightCard(card, hovered):
	var highlightOffset = 15
	if hovered and $"../PlayerHand".isCardInHand(card):
		#card.scale = Vector2(HIGHLIGHT_SIZE, HIGHLIGHT_SIZE)
		$"../PlayerHand".animateCard(card, Vector2(card.position.x, card.position.y - highlightOffset))
		card.z_index = 15
	elif isHovering:
		if card == cardZoomed:
			oldZoomPos = Vector2($"../PlayerHand".calcCardPosition($"../PlayerHand".playerHand.find(card)), $"../PlayerHand".HAND_Y_POS)
			oldZoomZ = $"../PlayerHand".playerHand.find(card) + 1
		else:
			$"../PlayerHand".animateCard(card, Vector2($"../PlayerHand".calcCardPosition($"../PlayerHand".playerHand.find(card)), $"../PlayerHand".HAND_Y_POS))
			card.z_index = $"../PlayerHand".playerHand.find(card) + 1

#func connectCardSignals(card):
	#card.connect("hovOn", hoverOn)
	#card.connect("hovOff", hoverOff)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screenSize = get_viewport_rect().size # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("UNUSED_PARAMETER")
func _process(delta: float) -> void:
	if cardDragged:
		var mpos = get_global_mouse_position()
		cardDragged.position = Vector2(clamp(mpos.x, 0, screenSize.x), clamp(mpos.y, 0, screenSize.y))
	else:
		var card = findCard()
		if isHovering and (cardZoomed or card != cardHovering):
			highlightCard(cardHovering, false)
			isHovering = false
			cardHovering = null
		if card and !isHovering and !cardZoomed and !isFocused and card in $"../PlayerHand".playerHand and !card.isMoving and !$"../BlackScreen".isCovered:
			isHovering = true
			highlightCard(card, true)
			cardHovering = card


func _on_hq_focused_hq() -> void:
	isFocused = true
	if isHovering:
		isHovering = false
		highlightCard(findCard(), false)


func _on_hq_un_focus_hq() -> void:
	isFocused = false
