extends Node2D

var sCard

const cardPos = Vector2(150, 225)

var sName
var twistCount
var playedTwists = 0

@onready
var info = $"..".scheme
const OOS = Vector2(1047, -1224)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	sName = info.sName
	twistCount = info.twistCount
	
	var cardScene = preload("res://Scenes/Card.tscn")
	sCard = cardScene.instantiate()
	sCard.identifier = "Scheme"
	sCard.initSprite(info.spritePath)
	sCard.z_index = 5
	sCard.position = cardPos
	$"../PlayerHand".addCardToManager(sCard)
	
	connect("schemeLabel", $"../ExtraLabels".showLabel)
	connect("removeSchemeLabel", $"../ExtraLabels".removeLabel)

func twist():
	playedTwists += 1
	$"../EffectManager".SchemeTwistLinks[sName].call(playedTwists)
	await $"../BlackScreen".KOfromHQ($"../EffectManager".sixCostFilter)

func displayTwists(on):
	if on:
		$"../ExtraLabels".showLabel(str("Scheme Twists: ", playedTwists))
	else:
		$"../ExtraLabels".removeLabel()
