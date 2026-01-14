extends Node2D

var sCard

const cardPos = Vector2(150, 225)

var sName
var twistCount
var playedTwists = 0
var overrides

@onready
var info = $"../..".scheme
const OOS = Vector2(1047, -1224)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	sName = info.sName
	twistCount = info.twistCount
	overrides = info.overrides
	if sName in $"../EffectManager".SchemeSetupLinks:
		$"../EffectManager".SchemeSetupLinks[sName].call()
	var cardScene = preload("res://Scenes/Card.tscn")
	sCard = cardScene.instantiate()
	sCard.identifier = "Scheme"
	sCard.initSprite(info.spritePath)
	sCard.z_index = 5
	sCard.position = cardPos
	$"../PlayerHand".addCardToManager(sCard)
	sCard.extraText.append(str("Scheme Twists: ", playedTwists))

func twist():
	playedTwists += 1
	sCard.extraText[0] = str("Scheme Twists: ", playedTwists)
	await $"../EffectManager".SchemeTwistLinks[sName].call(playedTwists)
	if $"../..".playerCount == 1:
		await $"../BlackScreen".KOfromHQ($"../EffectManager".sixCostFilter)

#func displayTwists(on):
	#if on:
		#$"../ExtraLabels".showLabel(str("Scheme Twists: ", playedTwists))
	#else:
		#$"../ExtraLabels".removeLabel()
