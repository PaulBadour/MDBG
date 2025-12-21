extends Node2D

var cards = []
var discard = []
var vicPile = []

const OOS = Vector2(-100, -100)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func initStarterDeck():
	#var agent = "res://cards/shield-agent.png"
	#var trooper = "res://cards/shield-trooper.png"
	var heroScene = preload("res://Scenes/Hero.tscn")
	for i in range(8):
		var newCard = heroScene.instantiate()
		newCard.initHero(HeroData.SHIELD_AGENT)
		get_parent().addCardToManager(newCard)
		#newCard.initSprite(agent)
		cards.insert(0, newCard)
		
	for i in range(4):
		var newCard = heroScene.instantiate()
		newCard.initHero(HeroData.SHIELD_TROOPER)
		get_parent().addCardToManager(newCard)
		#newCard.initSprite(trooper)
		cards.insert(0, newCard)
		
	for i in cards:
		i.position = OOS

	shuffleDeck()

func shuffleDeck():
	cards.shuffle()

# Grossly oversimplified
func draw():
	if cards.size() == 0:
		if discard.size() == 0:
			return null
		discard.shuffle()
		while discard.size() > 0:
			cards.insert(0, discard.pop_front())
			#get_parent().updateDiscardCount(discard.size())
		get_parent().updateDiscardCount(discard.size())
	get_parent().updateDeckCount(cards.size() - 1)
	return cards.pop_front()

func discardCard(card):
	discard.insert(0, card)
	card.position = OOS
	get_parent().updateDiscardCount(discard.size())
