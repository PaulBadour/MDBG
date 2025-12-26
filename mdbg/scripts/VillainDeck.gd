extends "res://scripts/Pile.gd"

@onready
var villains = $"..".villains
#var henchman = [GameData.HENCHMAN_SENTINEL]
#var villains = [GameData.HYDRA_VILLAINS]
var henchCount = 3
var masterStrikeCount = 1
var bystanderCount = 1

const OOS = Vector2(-200, -500)

func _ready() -> void:
	var vilScene = preload("res://Scenes/Villain.tscn")
	var cardScene = preload("res://Scenes/Card.tscn")
	
	
	for t in villains:
		if "team" not in t.keys():
			for j in t.keys():
				#print(j, t[j])
				for k in range(t[j]):
					var v = vilScene.instantiate()
					$"../PlayerHand".addCardToManager(v)
					v.initVil(j)
					addCards(v)
					v.position = OOS
		else:
			for i in range(henchCount):
				var v = vilScene.instantiate()
				$"../PlayerHand".addCardToManager(v)
				v.initVil(t)
				addCards(v)
				v.position = OOS
	
	for i in range(masterStrikeCount):
		var ms = cardScene.instantiate()
		ms.identifier = "Master Strike"
		ms.initSprite("res://cards/Base/Other/MasterStrike.png")
		$"../PlayerHand".addCardToManager(ms)
		addCards(ms)
		ms.position = OOS
	
	#print("good unitl bystanders")
	await $"../Bystanders".ready
	
	for i in range(bystanderCount):
		addCards($"../Bystanders".draw())
	
	#print("good unitl scheme")
	await $"../Scheme".ready
	
	
	for i in range($"../Scheme".twistCount):
		var t = cardScene.instantiate()
		t.identifier = "Twist"
		t.initSprite("res://cards/Base/Other/SchemeTwist.png")
		t.position = OOS
		$"../PlayerHand".addCardToManager(t)
		addCards(t)
		
	shuffle()
	#print("Vil deck made With ", cards.size())
	

func draw():
	var c = super()
	if !c:
		$"..".tie()
	return c
