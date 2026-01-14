extends Node2D

const CARD_WIDTH = 190
const HAND_Y_POS = 800

const HERO_SCRIPT = preload("res://scripts/Hero.gd")

var handSize = 6
var playerHand = []
var deck
var played = []
var vicPile = []

var holdover = []

var killOrRecruit = false

var cardBeingPlayed

var extraDraws = 0
var extraTurn = 0

var centerScreenx

var eventCards = {}

signal deckCount
signal discardCount

signal addAttack
signal addRecruit
signal endTurn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	centerScreenx = get_viewport().size.x / 2
	
	var deckScene = preload("res://Scenes/Deck.tscn")
	deck = deckScene.instantiate()
	add_child(deck)
	deck.initStarterDeck()

	drawHand()

func _input(event):
	if event is InputEventKey and event.keycode == KEY_W and event.is_pressed() and !event.is_echo():
		#return
		$"../City".addBystander($"../Bystanders".draw())
		#addWound(1)
		#print(deck.cards)

func isCardInHand(card):
	for i in playerHand:
		if i == card:
			return true
	return false

func isCardPlayed(card):
	for i in played:
		if i == card:
			return true
	return false

func playCard(card):
	#if isCardInHand(card):
	cardBeingPlayed = card
	var pr = await $"../EffectManager".prereq(card)
	if !pr:
		print("Failed prereq")
		updateHandPositions()
		return
	
	played.insert(0, card)
	card.position = Vector2(2000, 2000)
	$"../CardManager".hoverOff(card)
	
	if card.attack:
		emit_signal("addAttack", card.attack)
	
	if card.recruit:
		emit_signal("addRecruit", card.recruit)
		
	removeFromHand(card)
	await $"../EffectManager".effect(card)
	cardBeingPlayed = null

func addCardToManager(card):
	$"../CardManager".add_child(card, true)

func addCardToHand(card):
	playerHand.insert(0, card)
	updateHandPositions()

func updateHandPositions():
	#print("Updating hand pos")
	for i in range(playerHand.size()):
		var newPostition = Vector2(calcCardPosition(i), HAND_Y_POS)
		var card = playerHand[i]
		card.handPos = newPostition
		animateCard(card, newPostition)

func calcCardPosition(num):
	var totalWidth = (handSize) * CARD_WIDTH
	var xoffset = centerScreenx + (num * CARD_WIDTH) - totalWidth / 2.0
	return xoffset

func animateCard(card, pos):
	card.position = pos
	return
	#var tween = get_tree().create_tween()
	#tween.tween_property(card, "position", pos, .2)

func removeFromHand(card):
	playerHand.erase(card)
	updateHandPositions()

func discardHand():
	while playerHand.size() > 0:
		discardCard(playerHand[0], true)

func discardCard(c, endOfTurn = false):
	if !endOfTurn:
		if is_instance_of(c, HERO_SCRIPT) and c.getFuncName() == "Cyclops-Unending Energy":
			return
	playerHand.erase(c)
	deck.discardCard(c)

func deleteCard(c):
	playerHand.erase(c)
	updateHandPositions()

func drawCard():
	var d = deck.draw()
	if d:
		addCardToHand(d)
		extraDraws += 1

func drawHand():
	for i in range(handSize):
		drawCard()
	extraDraws = 0
	handSize = 6
	while holdover.size() > 0:
		addCardToHand(holdover.pop_front())
	updateDeckCount()
	updateHandPositions()

func updateDeckCount(num=null):
	if num:
		emit_signal("deckCount", num)
	else:
		emit_signal("deckCount", deck.cards.size())

func updateDiscardCount(num=null):
	if num:
		emit_signal("discardCount", num)
	else:
		emit_signal("discardCount", deck.discard.size())

# End of turn
func _on_button_button_down() -> void:
	$"../CardManager".unzoomCard()
	if !killOrRecruit:
		#print("no kill/recruit")
		if countWoundsInHand() > 0:
			#print("wounds found")
			await $"../BlackScreen".chooseCardKO(0, 0, ["hand"], $"../EffectManager".woundFilter)
	emit_signal("endTurn")
	discardHand()
	killOrRecruit = false
	while played.size() > 0:
		var c = played[0]
		played.erase(c)
		if c not in holdover:
			deck.discardCard(c)

	drawHand()
	eventCards.clear()
	$"../ModifierManager".removeModifiers($"../ModifierManager".Timing.END_OF_TURN)
	if $"..".PLAYER_COUNT > 1:
		if extraTurn > 0:
			extraTurn -= 1
			$"../..".socket.send_text("Rewind Turn")
		else:
			$"../..".socket.send_text("End Turn")
	else:
		$"..".newTurn()
	#if extraTurn > 0:
		#if $"..".PLAYER_COUNT > 1:
			#$"../..".socket.send_text("Rewind Turn")
		#else:
			#$"..".newTurn()
	#else:
		#if $"..".PLAYER_COUNT > 1:
			#$"../..".socket.send_text("End Turn")
		#else:
			#$"..".newTurn()

func holdoverCard(c):
	if c in playerHand:
		removeFromHand(c)
	holdover.append(c)
	c.position = Vector2(-1127, 113)

func classCount(c, skipPlayed = true, countHand = false):
	var count = 0
	var start = 0
	if skipPlayed:
		start = 1
	for i in range(start, played.size()):
		if played[i].hClass == c:
			count += 1
	if countHand:
		for i in playerHand:
			if i.identifier == "Hero" and i.hClass == c:
				count += 1
	return count

func teamCount(c, skipPlayed = true, countHand = false):
	var count = 0
	var start = 0
	if skipPlayed:
		start = 1
	for i in range(start, played.size()):
		if played[i].team == c:
			count += 1
	if countHand:
		for i in playerHand:
			if i.identifier == "Hero" and i.team == c:
				count += 1
	return count

func saveBystander():
	if $"../Bystanders".countLeft > 0:
		var v = $"../Bystanders".draw()
		vicPile.insert(0, v)
	#print(str("VP: ", getVP()))

func getVP():
	var c = 0
	for i in vicPile:
		c += i.vp
	return c

func countWoundsInHand():
	var count = 0
	for i in playerHand:
		if i.identifier == "Wound":
			count += 1
	return count

func addWound(num):
	var divingBlockInHand = false
	for i in playerHand:
		if i.identifier == "Hero" and i.getFuncName() == "Captain America-Diving Block":
			divingBlockInHand = true
			break
	if !divingBlockInHand:
		for i in played:
			if i.identifier == "Hero" and i.getFuncName() == "Captain America-Diving Block":
				divingBlockInHand = true
				break
	
	
	for i in num:
		if divingBlockInHand:
			await $"../EffectManager".Diving_Block()
		else:
			deck.discard.append($"../Wounds".draw())
			deck.updateDiscardCount()

func autoplay():
	var limit = 0
	while playerHand.size() > limit:
		if playerHand[limit].identifier != "Hero":
			limit += 1
		else:
			await playCard(playerHand[limit])
