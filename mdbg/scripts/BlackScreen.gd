extends Node2D

const TRANSPARENCY = .8

const MAX_ROW = 8
const START_LOC = Vector2(100, 200)
const X_INCR = 200
const Y_INCR = 300

const BUTTON_LOCATION = Vector2(1700, 400)

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
	#get_child(0).color = Color(0.0, 0.0, 0.0, TRANSPARENCY)
	position = Vector2(0, 0)
	isCovered = true

func disappear():
	#get_child(0).color = Color(0.0, 0.0, 0.0, 0.0)
	position = Vector2(2000, 2000)
	isCovered = false
	
func showCards(cards, clickable=false):
	appear()
	var currX = START_LOC.x
	var currY = START_LOC.y
	
	if clickable:
		isClickable = true
	
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
		$"../PlayerHand".discardCard(i)
		i.position = Vector2(-500, -500)

	$"../PlayerHand".updateHandPositions()
	
	stopShowCards()
	return true

# possible locations: "hand", "discard", "Played"
func chooseCardKO(minKO, maxKO, locations, filter=null):
	var hand = $"../PlayerHand".playerHand
	
	var stack = []
	print(locations)
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
	
	print(stack)
	if filter:
		#print("filtering")
		var newStack = []
		for i in stack:
			if filter.call(i):
				newStack.append(i)
		stack = newStack
	print(stack)
	maxClick = maxKO
	if stack.size() == 0:
		return false

	showCards(stack, true)
	get_node("KOButton").position = BUTTON_LOCATION
	var valid = false
	while !valid:
		await get_node("KOButton").pressed
		if clicked.size() >= minKO:
			valid = true

	get_node("KOButton").position = Vector2(1000, -200)
	print(clicked)
	
	for i in clicked:
		
		$"../KODeck".addCards(i)
		if i in hand:
			#print("Removing hand wound")
			await $"../PlayerHand".deleteCard(i)
			i.position = Vector2(-500, -500)
		if i in $"../PlayerHand".deck.discard:
			#print("Removing deck wound")
			await $"../PlayerHand".deck.discard.erase(i)
			i.position = Vector2(-500, -500)
			$"../PlayerHand".updateDiscardCount($"../PlayerHand".deck.discard.size())
		if i in $"../PlayerHand".played:
			$"../PlayerHand".played.erase(i)
			i.position = Vector2(-500, -500)
		

	$"../PlayerHand".updateHandPositions()
	stopShowCards()

	if clicked.size() == 0:
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
