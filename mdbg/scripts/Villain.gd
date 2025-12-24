extends "res://scripts/Card.gd"

var cardName
var attack

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

func initVil(info: Dictionary):
	identifier = "Villain"
	attack = info.attack
	cardName = info.name
	vp = info.vp
	spritePath = info.spritePath
	
	initSprite(spritePath)

func getFuncName():
	pass
