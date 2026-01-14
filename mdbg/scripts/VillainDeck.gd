extends "res://scripts/Pile.gd"

@onready
var villains = $"../..".villains
#var henchman = [GameData.HENCHMAN_SENTINEL]
#var villains = [GameData.HYDRA_VILLAINS]
var henchCount
var masterStrikeCount
var bystanderCount

const OOS = Vector2(-200, -500)

func _ready() -> void:
	var vilScene = preload("res://Scenes/Villain.tscn")
	var cardScene = preload("res://Scenes/Card.tscn")
	
	if "Bystanders" in $"../Scheme".overrides.keys():
		bystanderCount = $"../Scheme".overrides["Bystanders"]
	else:
		match $"../..".playerCount:
			1:
				bystanderCount = 1
			2:
				bystanderCount = 2
			3:
				bystanderCount = 8
			4:
				bystanderCount = 8
			5:
				bystanderCount = 12
			
	if $"../..".playerCount == 1:
		masterStrikeCount = 1
		henchCount = 3
	else:
		masterStrikeCount = 5
		henchCount = 10
	
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
	

	for i in range(bystanderCount):
		addCards($"../Bystanders".draw())
	
	
	for i in range($"../Scheme".twistCount):
		var t = cardScene.instantiate()
		t.identifier = "Twist"
		t.initSprite("res://cards/Base/Other/SchemeTwist.png")
		t.position = OOS
		$"../PlayerHand".addCardToManager(t)
		addCards(t)
		
	if !$"../..".host:
		print("Not host")
		shuffle($"../..".villainShuffleCode)
	elif $"../..".playerCount > 1:
		#print("Making code")
		var hsc = shuffle()
		#print("Sending: ", hsc)
		$"../..".socket.send_text(str("VillainDeck:", JSON.stringify(hsc)))
	else:
		#print("Singleplayer")
		shuffle()
	$VilLabel.text = str("Villain Deck: ", cards.size())


func draw():
	var c = super()
	$VilLabel.text = str("Villain Deck: ", cards.size())
	if !c:
		$"..".tie()
	return c
