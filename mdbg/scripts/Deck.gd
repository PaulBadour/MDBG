extends "res://scripts/Pile.gd"

var discard = []
var vicPile = []

const OOS = Vector2(-100, -100)


func initStarterDeck():
	#var agent = "res://cards/shield-agent.png"
	#var trooper = "res://cards/shield-trooper.png"
	var heroScene = preload("res://Scenes/Hero.tscn")
	for i in range(8):
		var newCard = heroScene.instantiate()
		newCard.initHero(HeroData.SHIELD_AGENT)
		get_parent().addCardToManager(newCard)
		#newCard.initSprite(agent)
		addCards(newCard)
		
	for i in range(4):
		var newCard = heroScene.instantiate()
		newCard.initHero(HeroData.SHIELD_TROOPER)
		get_parent().addCardToManager(newCard)
		#newCard.initSprite(trooper)
		addCards(newCard)
		
	for i in cards:
		i.position = OOS

	shuffle()

# Grossly oversimplified and overwriting the super class
func draw():
	if cards.size() == 0:
		if discard.size() == 0:
			return null
		discard.shuffle()
		#while discard.size() > 0:
			#cards.insert(0, discard.pop_front())
			##get_parent().updateDiscardCount(discard.size())
		addCards(discard)
		discard.clear()
		get_parent().updateDiscardCount(discard.size())
	get_parent().updateDeckCount(cards.size() - 1)
	return cards.pop_front()

func discardCard(card):
	discard.insert(0, card)
	card.position = OOS
	get_parent().updateDiscardCount(discard.size())
