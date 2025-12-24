extends "res://scripts/Pile.gd"

var henchman = [GameData.HENCHMAN_SENTINEL]
var henchCount = 3

const OOS = Vector2(-200, -500)

func _ready() -> void:
	var vilScene = preload("res://Scenes/Villain.tscn")
	for j in henchman:
		for i in range(henchCount):
			var v = vilScene.instantiate()
			v.initVil(j)
			$"../PlayerHand".addCardToManager(v)
			addCards(v)
			v.position = OOS
