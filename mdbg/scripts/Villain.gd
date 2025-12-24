extends "res://scripts/Card.gd"

var cardName
var attack
var team

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

func initVil(info: Dictionary):
	identifier = "Villain"
	team = info.team
	attack = info.attack
	cardName = info.name
	vp = info.vp
	spritePath = info.spritePath
	
	initSprite(spritePath)

func getFuncName():
	return str(team, "-", cardName)
