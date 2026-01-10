extends Node2D

const TRANSPARENCY = .8

const MAX_ROW = 8
const START_LOC = Vector2(100, 200)
const X_INCR = 200
const Y_INCR = 300

const BUTTON_LOCATION = Vector2(1700, 400)

var customButtons = []

var isCovered = false
var shownCards = []
var lastLocations = []
var lastIndexes = []

var isClickable = false
var clicked = []
var maxClick

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and isClickable:
		var c = $"../CardManager".findCard()
		if c in clicked:
			clicked.erase(c)
		elif c and (clicked.size() < maxClick or maxClick == 0):
			clicked.append(c)

func _ready():
	get_node("Drapes").color = Color(0.0, 0.0, 0.0, TRANSPARENCY)
	get_node("DiscardButton").add_theme_font_size_override("font_size", 50)
	disappear()

func appear():
	position = Vector2(0, 0)
	isCovered = true

func disappear():
	position = Vector2(2000, 2000)
	isCovered = false
	
func showCards(cards, clickable=false):
	appear()
	var currX = START_LOC.x
	var currY = START_LOC.y
	
	if clickable:
		isClickable = true
	
	print(cards)
	for i in cards:
		
		lastLocations.append(i.position)
		lastIndexes.append(i.z_index)
		i.position = Vector2(currX, currY)
		i.z_index = 21
		
		shownCards.append(i)
		if shownCards.size() % MAX_ROW == 0:
			currY += Y_INCR
			currX = START_LOC.x
		else:
			currX += X_INCR
	#print(lastLocations)

func stopShowCards():
	
	for i in range(shownCards.size()):
		if !shownCards[i] in clicked:
			shownCards[i].position = lastLocations[i]
		shownCards[i].z_index = lastIndexes[i]
		

	isClickable = false
	shownCards.clear()
	lastLocations.clear()
	lastIndexes.clear()
	clicked.clear()
	disappear()






# Bug if played card is played where a choice may be

func chooseCardDiscard(minDisc, maxDisc, exclude=true):
	var hand = $"../PlayerHand".playerHand
	if exclude:
		hand.erase($"../PlayerHand".cardBeingPlayed)
	maxClick = maxDisc
	if hand.size() == 0:
		return false

	showCards(hand, true)
	get_node("DiscardButton").position = BUTTON_LOCATION
	var valid = false
	while !valid:
		await get_node("DiscardButton").pressed
		if clicked.size() >= minDisc:
			valid = true

	get_node("DiscardButton").position = Vector2(1000, -200)
	#print(clicked)
	
	for i in clicked:
		await $"../PlayerHand".discardCard(i)
		i.position = Vector2(-500, -500)

	$"../PlayerHand".updateHandPositions()
	
	stopShowCards()
	return true

# possible locations: "hand", "discard", "Played"
func chooseCardKO(minKO, maxKO, locations, filter=null):
	var hand = $"../PlayerHand".playerHand
	
	var stack = []
	#print(locations)
	for i in locations:
		if i == "hand":
			print("hand")
			stack.append_array(hand)
		if i == "discard":
			#print("discard")
			stack.append_array($"../PlayerHand".deck.discard)
		if i == "played":
			print("played")
			stack.append_array($"../PlayerHand".played)
	
	#print(stack)
	if filter:
		#print("filtering")
		var newStack = []
		for i in stack:
			if filter.call(i):
				newStack.append(i)
		stack = newStack
	maxClick = maxKO
	if stack.size() == 0:
		return false
	
	if stack.size() < minKO:
		minKO = stack.size()
	
	showCards(stack, true)
	get_node("KOButton").position = BUTTON_LOCATION
	var valid = false
	while !valid:
		await get_node("KOButton").pressed
		if clicked.size() >= minKO:
			valid = true

	get_node("KOButton").position = Vector2(1000, -200)
	#print(clicked)
	
	for i in clicked:
		
		$"../KODeck".addCards(i)
		#print("Adding ", i, " To KO")
		if i in hand:
			#print("Removing hand wound")
			$"../PlayerHand".deleteCard(i)
			await $"../PlayerHand".updateHandPositions()
			i.position = Vector2(-500, -500)
		if i in $"../PlayerHand".deck.discard:
			#print("Removing deck wound")
			$"../PlayerHand".deck.discard.erase(i)
			i.position = Vector2(-500, -500)
			$"../PlayerHand".updateDiscardCount($"../PlayerHand".deck.discard.size())
		if i in $"../PlayerHand".played:
			$"../PlayerHand".played.erase(i)
			i.position = Vector2(-500, -500)
		

	$"../PlayerHand".updateHandPositions()
	var c = clicked.size()
	stopShowCards()

	if c == 0:
		return false
	
	return true

func orderTopDeck(num):
	var hand = $"../PlayerHand"
	#print("num is ", num)
	showCards(hand.deck.getTop(num), true)
	maxClick = num
	
	get_node("OrderButton").position = BUTTON_LOCATION
	
	var valid = false
	while !valid:
		await get_node("OrderButton").pressed
		if clicked.size() == num:
			valid = true

	get_node("OrderButton").position = Vector2(1000, -200)

	for i in range(clicked.size()):
		hand.deck.cards[i] = clicked[i]
		clicked[i].position = Vector2(3000, 0)
	stopShowCards()
	return true


func KOFromDeck(minKO, maxKO, number):
	maxClick = maxKO
	var deck = $"../PlayerHand".deck
	
	var stack = deck.getTop(number)
	
	if stack == null:
		return false

	showCards(stack, true)
	get_node("KOButton").position = BUTTON_LOCATION
	var valid = false
	while !valid:
		await get_node("KOButton").pressed
		if clicked.size() >= minKO:
			valid = true

	get_node("KOButton").position = Vector2(1000, -200)
	
	for i in clicked:
		
		$"../KODeck".addCards(i)
		deck.cards.erase(i)
	deck.updateDrawCount()

	stopShowCards()

	if clicked.size() == 0:
		return false
	
	return true

func discardFromDeck(minDisc, maxDisc, number):
	maxClick = maxDisc
	var deck = $"../PlayerHand".deck
	
	var stack = deck.getTop(number)
	
	if stack == null:
		return false

	showCards(stack, true)
	get_node("DiscardButton").position = BUTTON_LOCATION
	var valid = false
	while !valid:
		await get_node("DiscardButton").pressed
		if clicked.size() >= minDisc:
			valid = true

	get_node("DiscardButton").position = Vector2(1000, -200)
	
	for i in clicked:
		
		deck.discard.append(i)
		deck.cards.erase(i)
		i.position = Vector2(-1130, 1224)
	deck.updateDrawCount()
	deck.updateDiscardCount()

	stopShowCards()

	if clicked.size() == 0:
		return false
	
	return true

func customChoices(text : Array, funcs : Array):
	if text.size() != funcs.size():
		push_error("fucked up custom choices")
		return
	appear()
	#customButtons = []
	var c = 0
	var offset = 150
	for i in text:
		var b = $DiscardButton.duplicate()
		add_child(b)
		b.text = i
		customButtons.append(b)
		b.position = Vector2(BUTTON_LOCATION.x - 700, BUTTON_LOCATION.y + (c * offset))
		b.button_down.connect(funcs[c])
		c += 1
	
	#get_node("DiscardButton").position = BUTTON_LOCATION
	await $"../EffectManager".finishCustom
	
	deleteCustomButtons()
	disappear()

func customCardChoices(minChoices, maxChoices, buttonText, cards):
	maxClick = maxChoices
	showCards(cards, true)
	
	var button = $DiscardButton.duplicate()
	add_child(button)
	button.text = buttonText
	button.position = BUTTON_LOCATION
	var valid = false
	while !valid:
		await button.pressed
		if clicked.size() >= minChoices:
			valid = true
	var c = clicked.duplicate(true)
	button.queue_free()
	stopShowCards()
	return c

func deleteCustomButtons():
	for i in customButtons:
		i.queue_free()
	customButtons.clear()

func KOfromHQ(filter):
	maxClick = 1
	var stack = $"../HQ".hq
	if filter:
		var newStack = []
		for i in stack:
			if filter.call(i):
				newStack.append(i)
		stack = newStack
	showCards(stack, true)
	get_node("KOButton").position = BUTTON_LOCATION
	var valid = false
	while !valid:
		await get_node("KOButton").pressed
		if clicked.size() == 1:
			valid = true

	get_node("KOButton").position = Vector2(1000, -200)
	
	$"../HQ".KOhero(clicked[0])
	
	stopShowCards()
	return true

func infoPanel():
	var l = get_node("Info")
	var schemeText = str("Scheme: ", $"../..".scheme.sName, "\n")
	var mastermindText = str("Mastermind: ", $"../..".mastermind.mName, "\n")
	
	var heroText = "Heros: "
	for i in $"../..".heros:
		if $"../..".heros[0] == i:
			heroText = str(heroText, GameData.BASE_HEROS[i][0].heroName)
		else:
			heroText = str(heroText, ", ", GameData.BASE_HEROS[i][0].heroName)
	heroText = str(heroText, "\n")
	
	var villainText = "Villains: "
	for i in $"../..".villains:
		if "team" in i.keys():
			villainText = str(villainText, i.name)
		else:
			villainText = str(villainText, i.keys()[0].team)
		if i != $"../..".villains[-1]:
			villainText = str(villainText, ", ")
	villainText = str(villainText, "\n")
	
	await appear()
	l.position = Vector2(1000, 500)
	l.text = str(schemeText, mastermindText, heroText, villainText, "Player Count: ", $"../..".playerCount)
	
	await get_tree().create_timer(3.0).timeout
	l.position = Vector2(1225, 2025)
	await disappear()
