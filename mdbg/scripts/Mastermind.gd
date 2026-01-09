extends Node2D

var mCard

const cardPos = Vector2(400, 225)

signal bystanderLabel
signal removeBystanderLabel

var leads
var masterStrike
var tactics = []
var attack
var mName
var bystanders = []

@onready
var info = $"../..".mastermind
const OOS = Vector2(904, -1224)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	attack = info.attack
	mName = info.mName
	$"../CardManager".connectBystanderSignal(self)
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
	if $"..".PLAYER_COUNT > 1:
		$"../..".socket.send_text(str("Tactic:", num))
	return tactics.pop_at(num)

func removeTactic(ind):
	tactics.pop_at(ind)
	print("Remaining tactics:")
	for i in tactics:
		print(i.tName)
	print("-------------")

func strike():
	print("Drew strike")
	$"../EffectManager".mastermind_strikes[getFuncName()].call()

func getFuncName():
	return str("Mastermind-", mName)

func displayBystanders(on):
	if on and bystanders.size() > 0:
		emit_signal("bystanderLabel", str("Bystanders: ", bystanders.size()))
		#b.text = str("Bystanders: ", bystanders)
		#b.position = Vector2(1500, 500)
	elif !on:
		emit_signal("removeBystanderLabel")
		#b.position = Vector2(-1500, -500)
