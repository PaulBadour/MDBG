extends "res://scripts/Card.gd"

var cardName
var attack
var team
#var bystanders = 0
var bystanders = []

signal bystanderLabel
signal removeBystanderLabel

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
	
	get_parent().connectBystanderSignal(self)

func displayBystanders(on):
	if on and bystanders.size() > 0:
		emit_signal("bystanderLabel", str("Bystanders: ", bystanders.size()))

	elif !on:
		emit_signal("removeBystanderLabel")

func getFuncName():
	return str(team, "-", cardName)
