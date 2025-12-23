extends "res://scripts/Pile.gd"

var discard = []

const OOS = Vector2(-500, 500)

func initStarterDeck():
	var heroScene = preload("res://Scenes/Hero.tscn")
	for i in range(8):
		var newCard = heroScene.instantiate()
		newCard.initHero(GameData.SHIELD_AGENT) # SHIELD_AGENT
		get_parent().addCardToManager(newCard)
		addCards(newCard)
		
	for i in range(4):
		var newCard = heroScene.instantiate()
		newCard.initHero(GameData.SHIELD_TROOPER) # SHIELD_TROOPER
		get_parent().addCardToManager(newCard)
		addCards(newCard)
	
	for i in cards:
		i.position = OOS

	shuffle()

# Grossly oversimplified and overwriting the super class
func draw():
	if cards.size() == 0:
		resetDiscardDraw()
		if cards.size() == 0:
			return null
		
	get_parent().updateDeckCount(cards.size() - 1)
	return cards.pop_front()

func resetDiscardDraw():
	if discard.size() == 0:
		return
	discard.shuffle()

	addCards(discard)
	discard.clear()
	updateDiscardCount()

func discardCard(card):
	discard.insert(0, card)
	card.position = OOS
	updateDiscardCount()

# This is gonna need to allow for discard shuffle mid get
func getTop(num=1):
	if cards.size() == 0:
		if discard.size() == 0:
			return null
		resetDiscardDraw()
	if num == 1:
		return cards[0]
	if num <= cards.size():
		var c = cards.slice(0, num-1)
		return c
	else:
		return null

func updateDiscardCount():
	get_parent().updateDiscardCount(discard.size())
	
func updateDrawCount():
	get_parent().updateDrawCount(cards.size())
