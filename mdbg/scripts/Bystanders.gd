extends "res://scripts/Pile.gd"

const CARD_PATH = "res://Scenes/Card.tscn"

var cardScene
var countLeft = 70
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cardScene = preload(CARD_PATH)

func draw():
	if countLeft == 0:
		return null
	var c = cardScene.initialize()
	c.vp = 1
	c.initSprite("res://cards/Base/Other/Bystander.png")
	return c
