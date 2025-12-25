extends Node2D

var mCard

const cardPos = Vector2(400, 225)

var leads
var masterStrike
var tactics = []
var attack
var mName

var info = GameData.RED_SKULL
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
		t.position = OOS
		$"../PlayerHand".addCardToManager(t)
		tactics.append(t)

func drawTactic():
	var num = randi_range(0, tactics.size() - 1)
	return tactics.pop_at(num)

func strike():
	print("Drew strike")
	$"../EffectManager".mastermind_strikes[getFuncName()].call()

func getFuncName():
	return str("Mastermind-", mName)
