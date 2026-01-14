extends "res://scripts/Pile.gd"

const CARD_PATH = "res://Scenes/Card.tscn"
const SPRITE_PATH = "res://cards/Base/Other/Wound.png"
var cardScene
var countLeft
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if "Wounds" in $"../Scheme".overrides.keys():
		countLeft = $"../Scheme".overrides["Wounds"]
	else:
		countLeft = 30
	updateLabel()
	cardScene = preload(CARD_PATH)

func draw(send=true):
	if countLeft == 0:
		return null
	var c = cardScene.instantiate()
	c.identifier = "Wound"
	#c.position = Vector2(c.BASE_SIZE, c.BASE_SIZE) 
	c.position = Vector2(0,-300)
	$"../PlayerHand".addCardToManager(c)
	c.initSprite(SPRITE_PATH)
	countLeft -= 1
	if countLeft == 0 and $"../Scheme".sName == "The Legacy Virus":
		$"..".lose()
	updateLabel()
	if $"../..".playerCount > 1 and send:
		$"../..".socket.send_text("Wound")
	return c

func updateLabel():
	$WoundLabel.text = str("Wounds: ", countLeft)
