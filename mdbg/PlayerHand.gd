extends Node2D

const HAND_COUNT = 6
const CARD_SCENE_PATH = "res://Scenes/Card.tscn"
const CARD_WIDTH = 190
const HAND_Y_POS = 800

var playerHand = []
var centerScreenx
var deck

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	centerScreenx = get_viewport().size.x / 2
	
	var deckScene = preload("res://Scenes/Deck.tscn")
	deck = deckScene.instantiate()
	add_child(deck)
	deck.initStarterDeck()
	
	for i in range(HAND_COUNT):
		
		addCardToHand(deck.draw())
		
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
	var totalWidth = (HAND_COUNT - 1) * CARD_WIDTH
	var xoffset = centerScreenx + (num * CARD_WIDTH) - totalWidth / 2.0
	return xoffset
	
func animateCard(card, pos):
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", pos, .2)

func removeFromHand(card):
	playerHand.erase(card)
	updateHandPositions()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
