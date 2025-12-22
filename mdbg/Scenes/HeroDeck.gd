extends "res://scripts/Pile.gd"

@onready
var HEROS = [GameData.Heros.IRON_MAN, GameData.Heros.SPIDER_MAN, GameData.Heros.CYCLOPS, GameData.Heros.WOLVERINE, GameData.Heros.HAWKEYE];
const OOS = Vector2(-200, -200)
signal SetupHQ

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	makeDeck()

func makeDeck():
	var heroScene = preload("res://Scenes/Hero.tscn")
	for i in HEROS:
		var cardsToAdd = GameData.BASE_HEROS[i]

		# Adding common cards
		for j in range(5):
			var c1 = heroScene.instantiate()
			c1.initHero(cardsToAdd[0])
			$"../PlayerHand".addCardToManager(c1)
			addCards(c1)
			c1.position = OOS
			
			var c2 = heroScene.instantiate()
			c2.initHero(cardsToAdd[1])
			$"../PlayerHand".addCardToManager(c2)
			addCards(c2)
			c2.position = OOS
		
		# Adding uncommons
		for j in range(3):
			var c3 = heroScene.instantiate()
			c3.initHero(cardsToAdd[2])
			$"../PlayerHand".addCardToManager(c3)
			addCards(c3)
			c3.position = OOS

		# Adding the rare
		var c4 = heroScene.instantiate()
		c4.initHero(cardsToAdd[3])
		$"../PlayerHand".addCardToManager(c4)
		addCards(c4)
		c4.position = OOS
		
		shuffle()
	
	emit_signal("SetupHQ")
