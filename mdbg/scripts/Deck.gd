extends Node2D

var cards = []
var discard = []
var vicPile = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func initStarterDeck():
	var agent = "res://cards/shield-agent.png"
	var trooper = "res://cards/shield-trooper.png"
	var cardScene = preload("res://Scenes/Card.tscn")
	for i in range(8):
		var newCard = cardScene.instantiate()
		get_parent().addCardToManager(newCard)
		newCard.initSprite(agent)
		cards.insert(0, newCard)
		
	for i in range(4):
		var newCard = cardScene.instantiate()
		get_parent().addCardToManager(newCard)
		newCard.initSprite(trooper)
		cards.insert(0, newCard)
		
	shuffleDeck()
	
func shuffleDeck():
	cards.shuffle()

# Grossly oversimplified
func draw():
	return cards.pop_front()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
