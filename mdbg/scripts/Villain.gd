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
	var par = get_parent()
	if b:
		bystanders.append(b)
		if bystanders.size() == 1:
			addExtraText("Bystanders: 1", "Bystanders")
			if par.get_node("../Scheme").sName == "Midtown Bank Robbery":
				par.get_node("../ModifierManager").createModifier(par.get_node("../ModifierManager").MidtownBankRobbery, self)
		else:
			editExtraText(str("Bystanders: ", bystanders.size()), "Bystanders")
			if par.get_node("../Scheme").sName == "Midtown Bank Robbery":
				attack += 1

func rescueBystander():
	var b
	if bystanders.size() > 0:
		b = bystanders.pop_front()
		if get_parent().get_node("../Scheme").sName == "Midtown Bank Robbery":
			attack -= 1
		if bystanders.size() == 0:
			clearBystanders()
	return b

func clearBystanders():
	assert(bystanders.size()==0)
	removeExtraText("Bystanders")
	
