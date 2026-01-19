extends "res://scripts/Card.gd"

var attack
var recruit
var cost
var team
var hClass
var effect
var heroName
var cardName
var secondaryClasses = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

func initHero(info: Dictionary):
	identifier = "Hero"
	attack = info.attack
	recruit = info.recruit
	cost = info.cost
	team = info.team
	hClass = info.hClass
	heroName = info.heroName
	cardName = info.cardName
	spritePath = info.spritePath
	
	if "secondaryClasses" in info.keys():
		secondaryClasses = info.secondaryClasses
	
	initSprite(spritePath)

func getFuncName():
	return str(heroName, "-", cardName)

func isClass(c):
	if c == hClass or c in secondaryClasses:
		return true
	return false
