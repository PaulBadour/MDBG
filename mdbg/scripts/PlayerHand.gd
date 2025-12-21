extends Node2D


const CARD_SCENE_PATH = "res://Scenes/Card.tscn"
const CARD_WIDTH = 190
const HAND_Y_POS = 800

var handSize = 6
var playerHand = []
var deck
var played = []

var centerScreenx

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
	if isCardInHand(card):
		removeFromHand(card)
		played.insert(0, card)
		$"../CardManager".hoverOff(card)
		
		if card.attack:
			emit_signal("addAttack", card.attack)
		
		if card.recruit:
			emit_signal("addRecruit", card.recruit)

func addCardToManager(card):
	$"../CardManager".add_child(card)

func addCardToHand(card):
	playerHand.insert(0, card)
	updateHandPositions()

func updateHandPositions():
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
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", pos, .2)

func removeFromHand(card):
	playerHand.erase(card)
	updateHandPositions()

func discardHand():
	while playerHand.size() > 0:
		var c = playerHand[0]
		playerHand.erase(c)
		deck.discardCard(c)
	
func drawHand():
	for i in range(handSize):
		addCardToHand(deck.draw())
	handSize = 6

func updateDeckCount(num):
	emit_signal("deckCount", num)

func updateDiscardCount(num):
	emit_signal("discardCount", num)

func _on_button_button_down() -> void:
	emit_signal("endTurn")
	discardHand()
	while played.size() > 0:
		var c = played[0]
		played.erase(c)
		deck.discardCard(c)

	drawHand()
