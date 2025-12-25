extends "res://scripts/Pile.gd"

const CARD_PATH = "res://Scenes/Card.tscn"
var cardScene
var countLeft = 30
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cardScene = preload(CARD_PATH)

func draw():
	if countLeft == 0:
		return null
	var c = cardScene.instantiate()
	c.identifier = "Bystander"
	c.position = Vector2(0,-200)
	$"../PlayerHand".addCardToManager(c)
	c.vp = 1
	c.initSprite("res://cards/Base/Other/Bystander.png")
	countLeft -= 1
	return c
