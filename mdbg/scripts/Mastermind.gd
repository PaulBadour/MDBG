extends Node2D

var mCard

const cardPos = Vector2(400, 225)

var leads
var masterStrike
var tactics = []
var attack
var mName
var bystanders = []
var identifier = "MMHandler"

@onready
var info = $"../..".mastermind
const OOS = Vector2(904, -1224)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	attack = info.attack
	mName = info.mName
	var cardScene = preload("res://Scenes/Card.tscn")
	mCard = cardScene.instantiate()
	mCard.identifier = "Mastermind"
	mCard.initSprite(info.spritePath)
	mCard.z_index = 5
	mCard.position = cardPos
	$"../PlayerHand".addCardToManager(mCard)

	for i in info.tactics.keys():
		var t = cardScene.instantiate()
		t.identifier = "Tactic"
		t.initSprite(info.tactics[i])
		t.tName = i
		t.vp = info.vp
		t.position = OOS
		$"../PlayerHand".addCardToManager(t)
		tactics.append(t)

func drawTactic():
	var num = randi_range(0, tactics.size() - 1)
	if $"..".PLAYER_COUNT > 1:
		$"../..".socket.send_text(str("Tactic:", num))
	return tactics.pop_at(num)

func removeTactic(ind):
	tactics.pop_at(ind)
	if tactics.size() == 0:
		$"..".win()

func strike():
	$"../EffectManager".mastermind_strikes[getFuncName()].call()

func getFuncName():
	return str("Mastermind-", mName)

func clearBystanders():
	if bystanders.size() > 0:
		bystanders.clear()
		mCard.removeExtraText("Bystanders")

func captureBystander(b):
	bystanders.append(b)
	if bystanders.size() == 1:
		mCard.addExtraText("Bystanders: 1", "Bystanders")
	else:
		mCard.editExtraText(str("Bystanders: ", bystanders.size()), "Bystanders")
