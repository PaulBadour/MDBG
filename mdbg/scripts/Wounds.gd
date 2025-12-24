extends "res://scripts/Pile.gd"

const CARD_PATH = "res://Scenes/Card.tscn"
const SPRITE_PATH = "res://cards/Base/Other/Wound.png"
var cardScene
var countLeft = 30
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cardScene = preload(CARD_PATH)

func draw():
	if countLeft == 0:
		return null
	var c = cardScene.instantiate()
	c.identifier = "Wound"
	#c.position = Vector2(c.BASE_SIZE, c.BASE_SIZE) 
	c.position = Vector2(0,-300)
	$"../PlayerHand".addCardToManager(c)
	c.initSprite(SPRITE_PATH)
	countLeft -= 1
	return c
