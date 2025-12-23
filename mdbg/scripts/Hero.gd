extends "res://scripts/Card.gd"

var attack
var recruit
var cost
var team
var hClass
var effect
var heroName
var cardName



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

func initHero(info: Dictionary):
	attack = info.attack
	recruit = info.recruit
	cost = info.cost
	team = info.team
	hClass = info.hClass
	heroName = info.heroName
	cardName = info.cardName
	spritePath = info.spritePath
	
	initSprite(spritePath)

func getFuncName():
	return str(heroName, "-", cardName)
