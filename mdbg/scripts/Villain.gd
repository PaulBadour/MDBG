extends "res://scripts/Card.gd"

var cardName
var attack
var team
var bystanders = []

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

func captureBystander(b):
	bystanders.append(b)
	if bystanders.size() == 1:
		extraText.push_front("Bystanders: 1")
		extraLabels.push_front("Bystanders")
	else:
		extraText[0] = str("Bystanders: ", bystanders.size())
