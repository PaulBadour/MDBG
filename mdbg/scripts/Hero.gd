extends "res://scripts/Card.gd"

var attack
var recruit
var cost
var team
var hClass
var effect
var heroName
var cardName
var spritePath


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

func initHero(info: Dictionary):
	attack = info.attack
	recruit = info.recruit
	cost = info.cost
	team = info.team
	hClass = info.hClass
	effect = info.effect
	heroName = info.heroName
	cardName = info.cardName
	spritePath = info.spritePath
	
	initSprite(spritePath)
