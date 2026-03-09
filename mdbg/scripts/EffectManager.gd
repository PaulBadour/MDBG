extends Node2D

signal finishCustom

@onready
var hand = $"../PlayerHand"
@onready
var res = $"../Resources"

# Cards have 3 types of effects:
# Post Effect: Most cards are like this
# Prereqs: Requirement to play a card
# Event: Does something when something else happens

# 

var links = {
	"Hero-SHIELD Trooper" : nullFunc,
	"Hero-SHIELD Agent" : nullFunc,
	"Hero-SHIELD Officer" : nullFunc,
	"Iron Man-Repulsor Rays" : Repulsor_Rays,
	"Iron Man-Quantum Breakthrough" : Quantum_Breakthrough,
	"Iron Man-Endless Invention" : Endless_Invention,
	"Iron Man-Arc Reactor" : Arc_Reactor,
	"Spiderman-Astonishing Strength" : Astonishing_Strength,
	"Spiderman-Great Responsibility" : Great_Responsibility,
	"Spiderman-Web Shooters" : Web_Shooters,
	"Spiderman-The Amazing Spiderman" : The_Amazing_Spiderman, # This kinda works, some bug with too many cards and card overlap
	"Wolverine-Berserker Rage" : Berserker_Rage,
	"Wolverine-Frenzied Slashing" : Frenzied_Slashing,
	"Wolverine-Keen Senses" : Keen_Senses,
	"Wolverine-Healing Factor" : Healing_Factor,
	"Cyclops-XMen United" : XMen_United,
	"Cyclops-Determination" : nullFunc,
	"Cyclops-Optic Blast" : nullFunc,
	"Cyclops-Unending Energy" : nullFunc,
	"Hawkeye-Quick Draw" : Quick_Draw,
	"Hawkeye-Team Player" : Team_Player,
	"Hawkeye-Impossible Trick Shot" : Impossible_Trickshot,
	"Hawkeye-Covering Fire" : Covering_Fire,
	"Emma Frost-Shadowed Thoughts" : Shadowed_Thoughts,
	"Emma Frost-Mental Discipline" : Mental_Discipline,
	"Emma Frost-Psychic Link" : Psychic_Link,
	"Emma Frost-Diamond Form" : Diamond_Form,
	"Nick Fury-Battlefield Promotion" : Battlefield_Promotion,
	"Nick Fury-High-Tech Weaponry" : HighTech_Weaponry,
	"Nick Fury-Legendary Commander" : Legendary_Commander,
	"Nick Fury-Pure Fury" : Pure_Fury,
	"Hulk-Unstoppable Hulk" : Unstoppable_Hulk,
	"Hulk-Growing Anger" : Growing_Anger,
	"Hulk-Crazed Rampage" : Crazed_Rampage,
	"Hulk-Hulk Smash!" : Hulk_Smash,
	"Captain America-Avengers Assemble!" : Avengers_Assemble,
	"Captain America-Perfect Teamwork" : Perfect_Teamwork,
	"Captain America-Diving Block" : nullFunc,
	"Captain America-A Day Unlike Any Other" : A_Day_Unlike_Any_Other,
	"Black Widow-Dangerous Rescue" : Dangerous_Rescue,
	"Black Widow-Mission Accomplished" : Mission_Accomplished,
	"Black Widow-Covert Operation" : Covert_Operation,
	"Black Widow-Silent Sniper" : Silent_Sniper,
	"Storm-Lightning Bolt" : Lightning_Bolt,
	"Storm-Gathering Storm Clouds" : Gathering_Storm_Clouds,
	"Storm-Spinning Cyclone" : Spinning_Cyclone,
	"Storm-Tidal Wave" : Tidal_Wave,
	"Thor-Surge of Power" : Surge_of_Power,
	"Thor-Odinson" : Odinson,
	"Thor-Call Lightning" : Call_Lightning,
	"Thor-God of Thunder" : God_of_Thunder,
	"Gambit-Stack the Deck" : Stack_the_Deck,
	"Gambit-Card Shark" : Card_Shark,
	"Gambit-Hypnotic Charm" : Hypnotic_Charm,
	"Gambit-High Stakes Jackpot" : High_Stakes_Jackpot,
	"Deadpool-Here, Hold This for a Second" : HoldThis_ForaSecond,
	"Deadpool-Oddball" : Oddball,
	"Deadpool-Hey, Can I Get a Do Over?" : CanIGetADoover,
	"Deadpool-Random Acts of Unkindness" : Random_Acts_of_Unkindness,
	"Rogue-Energy Drain" : Energy_Drain,
	"Rogue-Borrowed Brawn" : Borrowed_Brawn,
	"Rogue-Copy Powers" : Copy_Powers,
	"Rogue-Steal Abilities" : Steal_Abilities
}

var prereqs = {
	"Cyclops-Determination" : Determination_prereq,
	"Cyclops-Optic Blast" : Optic_Blast_prereq
}

# Counts all manual call aops
var aop_effects = {
	"Hawkeye-Covering Fire" : Covering_Fire_aop,
	"Emma Frost-Shadowed Thoughts" : Shadowed_Thoughts_aop,
	"Emma Frost-Psychic Link" : Psychic_Link,
	"Hulk-Crazed Rampage" : Crazed_Rampage,
	"Storm-Spinning Cyclone" : Spinning_Cyclone_aop,
	"Dr. Doom-Monarch's Decree" : Monarchs_Decree_aop,
	"Magneto-Crushing Shockwave" : Crushing_Shockwave_aop,
	"Enemies of Asgard-Ymir, Frost Giant King" : Ymir_fight_aop,
	"Loki-Vanishing Illusions" : Vanishing_Illusions_aop,
	"Loki-Whispers and Lies" : Whispers_and_Lies_aop,
	"Skrulls-Paibok the Power Skrull" : Paibok_fight_aop,
	"Masters of Evil-Melter" : Melter_fight_aop,
	"Gambit-Hypnotic Charm" : Hypnotic_Charm_aop,
	"Deadpool-Random Acts of Unkindness" : Random_Acts_of_Unkindness_aop,
	"Rogue-Steal Abilities" : Steal_Abilities_aop
}

# Iron Man

func Repulsor_Rays():
	if hand.classCount(GameData.Classes.RANGED) >= 1:
		res.addAttack(1)
	return true

func Quantum_Breakthrough():
	hand.drawCard()
	hand.drawCard()
	if hand.classCount(GameData.Classes.TECH):
		hand.drawCard()
		hand.drawCard()
	return true

func Endless_Invention():
	hand.drawCard()
	if hand.classCount(GameData.Classes.TECH):
		hand.drawCard()
	return true

func Arc_Reactor():
	var c = hand.classCount(GameData.Classes.TECH)
	if c:
		res.addAttack(c)
	return true

# SpiderMan

func Astonishing_Strength():
	var c = await hand.deck.reveal()
	if not c:
		return
	if c.cost <= 2:
		hand.drawCard()
	return true

func Great_Responsibility():
	var c = await hand.deck.reveal()
	if not c:
		return
	if c.cost <= 2:
		hand.drawCard()
	return true

func Web_Shooters():
	hand.saveBystander()
	var c = await hand.deck.reveal()
	if not c:
		return
	if c.cost <= 2:
		hand.drawCard()
	return true

func The_Amazing_Spiderman():
	var c = await hand.deck.reveal(3)
	var nc = 0
	for i in c:
		if i.cost <= 2:
			hand.deck.cards.erase(i)
			hand.addCardToHand(i)
			hand.deck.updateDrawCount()
		else:
			nc += 1
	if nc > 1:
		await $"../BlackScreen".orderTopDeck(nc)
	return true

# Wolverine

func Berserker_Rage():
	hand.drawCard()
	hand.drawCard()
	hand.drawCard()
	if hand.classCount(GameData.Classes.INSTINCT):
		res.addAttack(hand.extraDraws)
	return true

func Frenzied_Slashing():
	if hand.classCount(GameData.Classes.INSTINCT):
		hand.drawCard()
		hand.drawCard()
	return true

func Healing_Factor():
	var r = await $"../BlackScreen".chooseCardKO(0, 1, ["hand", "discard"], woundFilter, "KO 0 or 1 Wounds from hand or discard. If KO'd, draw 1 card")
	if r:
		hand.drawCard()
	return true

func Keen_Senses():
	if hand.classCount(GameData.Classes.INSTINCT):
		hand.drawCard()
	return true

# Cyclops

func Determination_prereq():
	var result = await $"../BlackScreen".chooseCardDiscard(1, 1, true, "Discard 1 card to play Determination")
	return result

func Optic_Blast_prereq():
	var result = await $"../BlackScreen".chooseCardDiscard(1, 1, true, "Discard 1 card to play Optic Blast")
	return result

# This can actually just be null function, needs some functionality in the discard code
# Event - prevent discard
# Unending Energy

func XMen_United():
	var c = hand.teamCount(GameData.Teams.XMEN, true, false)
	res.addAttack(c * 2)
	return true

# Hawkeye

func Covering_Fire():
	if hand.classCount(GameData.Classes.TECH) >= 1 and $"../..".playerCount > 1:
		var f1 = func():
			#$"../PlayerHand".drawCard()
			if $"../..".playerCount > 1:
				$"../..".socket.send_text("CardEffect:Hawkeye-Covering Fire:1")
			emit_signal("finishCustom")
			
		var f2 = func():
			if $"../..".playerCount > 1:
				$"../..".socket.send_text("CardEffect:Hawkeye-Covering Fire:2")
			#$"../BlackScreen".disappear()
			#$"../BlackScreen".deleteCustomButtons()
			#await $"../BlackScreen".chooseCardDiscard(1, 1)
			emit_signal("finishCustom")
			
		await $"../BlackScreen".customChoices(["Draw", "Discard"], [f1, f2], null, "Choose: Each other player draws 1 or each other player discards 1")

func Covering_Fire_aop(choice):
	if choice == "1":
		$"../PlayerHand".drawCard()
	else:
		$"../BlackScreen".toggleLockCheck()
		await $"../BlackScreen".chooseCardDiscard(1, 1, false, "Covering Fire: Discard 1 card")
		$"../BlackScreen".toggleLockCheck()

func Impossible_Trickshot():
	addCardEvent("Impossible Trickshot")

func Quick_Draw():
	await hand.drawCard()
	return true

func Team_Player():
	if hand.teamCount(GameData.Teams.AVENGERS):
		res.addAttack(1)
	return true

# Emma Frost

func Mental_Discipline():
	$"../PlayerHand".drawCard()
	
func Shadowed_Thoughts():
	var count = $"../PlayerHand".classCount(GameData.Classes.COVERT, true, false)
	if count > 0:
		var f1 = func():
			if $"../..".playerCount > 1:
				$"../..".socket.send_text("CardEffect:Emma Frost-Shadowed Thoughts:1")
			emit_signal("finishCustom")
			await $"../City".drawVilCard()
			res.addAttack(2)
		var f2 = func():
			emit_signal("finishCustom")
		await $"../BlackScreen".customChoices(["Play Villain Card", "Dont play villain card"], [f1, f2], null, "If villain card is played, gain 2 attack")

func Shadowed_Thoughts_aop(choice):
	assert(int(choice) == 1, "Fucked up staop")
	await $"../City".drawVilCard()

func Psychic_Link(choice=0):
	if $"../..".playerCount > 1 and $"..".yourTurn:
		assert(choice == 0, "Fucked up pl")
		$"../..".socket.send_text("CardEffect:Emma Frost-Psychic Link:1")
	var count = $"../PlayerHand".teamCount(GameData.Teams.XMEN, true, true)
	if count > 0:
		hand.drawCard()


func Diamond_Form():
	addCardEvent("Diamond Form")


# Nick Fury

func Battlefield_Promotion():
	var r = await $"../BlackScreen".chooseCardKO(0, 1, ["hand", "discard"], shieldFilter, "KO 0 or 1 SHIELD Heros. If KO'd, choose to gain SHIELD Officer")
	if r and $"../HQ".officerCount > 0:
		var f1 = func():
			$"../HQ".addOfficer()
			emit_signal("finishCustom")

		var f2 = func():
			emit_signal("finishCustom")
			
		await $"../BlackScreen".customChoices(["Add Officer", "Nothing"], [f1, f2], $"../HQ".displayOfficer, "Add SHIELD Officer or do nothing")

func HighTech_Weaponry():
	if hand.classCount(GameData.Classes.TECH):
		res.addAttack(1)

func Legendary_Commander():
	var count = hand.teamCount(GameData.Teams.SHIELD)
	res.addAttack(count)

func Pure_Fury():
	var cards = []
	var inds = []
	var count = 0
	for i in $"../KODeck".cards:
		if shieldFilter(i):
			count += 1
	if $"../Mastermind".attack < count:
		inds.append(-1)
		cards.append($"../Mastermind".mCard)
	
	for i in range($"../City".city.size()):
		if $"../City".city[i] != null and $"../City".city[i].attack < count:
			inds.append(i)
			cards.append($"../City".city[i])
	if cards.size() == 0:
		return
	var select = await $"../BlackScreen".customCardChoices(1, 1, "Defeat", cards.duplicate(true), true, "Defeat villain/mastermind with attack less than number of KO'd SHIELD Heros")
	var indind = cards.find(select)
	await $"../City"._on_fight_button_down(inds[indind])


# Hulk

func Unstoppable_Hulk():
	var r = await $"../BlackScreen".chooseCardKO(0, 1, ["hand", "discard"], woundFilter, "KO 0 or 1 Wounds from hand or discard. If KO'd, gain 2 attack")
	if r:
		res.addAttack(2)

func Growing_Anger():
	if $"../PlayerHand".classCount(GameData.Classes.STRENGTH, true, false) > 0:
		res.addAttack(1)

func Crazed_Rampage(choice=1):
	assert(int(choice) == 1)
	if $"../..".playerCount > 1 and $"..".yourTurn:
		$"../..".socket.send_text("CardEffect:Hulk-Crazed Rampage:1")
	$"../PlayerHand".addWound(1)


func Hulk_Smash():
	if $"../PlayerHand".classCount(GameData.Classes.STRENGTH, true, false) > 0:
		res.addAttack(5)


# Captain America

func Avengers_Assemble():
	var count = 0
	for i in GameData.Heros.values():
		if $"../PlayerHand".classCount(i, false, true) > 0:
			count += 1
	res.addRecruit(count)

func Perfect_Teamwork():
	var count = 0
	for i in GameData.Heros.values():
		if $"../PlayerHand".classCount(i, false, true) > 0:
			count += 1
	res.addAttack(count)

# Fuinction called on wound adding
func Diving_Block():
	var f1 = func():
		$"../PlayerHand".drawCard()
		$"../PlayerHand".deck.updateDrawCount()
		emit_signal("finishCustom")
	var f2 = func():
		$"../PlayerHand".deck.discard.append($"../Wounds".draw())
		$"../PlayerHand".deck.updateDiscardCount()
		emit_signal("finishCustom")
	$"../BlackScreen".toggleLockCheck()
	await $"../BlackScreen".customChoices(["Draw Card", "Add Wound"], [f1, f2], null, "Choose: Reveal Diving Block and draw a card or add wound to discard pile")
	$"../BlackScreen".toggleLockCheck()

func A_Day_Unlike_Any_Other():
	var count = $"../PlayerHand".teamCount(GameData.Teams.AVENGERS, true, false)
	if count > 0:
		res.addAttack(3 * count)

# Black Widow

func Dangerous_Rescue():
	if $"../PlayerHand".classCount(GameData.Classes.COVERT, true, false) > 0:
		var r = await $"../BlackScreen".chooseCardKO(0, 1, ["hand", "discard"], null, "KO 0 or 1 card. If KO'd, rescue a bystander")
		if r:
			hand.saveBystander()

func Mission_Accomplished():
	$"../PlayerHand".drawCard()
	if $"../PlayerHand".classCount(GameData.Classes.TECH, true, false) > 0:
		hand.saveBystander()

func Covert_Operation():
	var count = 0
	for i in $"../PlayerHand".vicPile:
		if i.identifier == "Bystander":
			count += 1
	res.addAttack(count)

func Silent_Sniper():
	var cards = []
	var inds = []
	
	if $"../Mastermind".bystanders.size() > 0:
		inds.append(-1)
		cards.append($"../Mastermind".mCard)
	
	for i in range($"../City".city.size()):
		if $"../City".city[i] != null and $"../City".city[i].bystanders.size() > 0:
			inds.append(i)
			cards.append($"../City".city[i])

	if cards.size() == 0:
		return
	var select = await $"../BlackScreen".customCardChoices(1, 1, "Defeat", cards.duplicate(true), true, "Defeat any villain/mastermind who has at least one bystander captured")
	var indind = cards.find(select)
	await $"../City"._on_fight_button_down(inds[indind])


# Storm

func Lightning_Bolt():
	$"../ModifierManager".citySpotModifier($"../ModifierManager".LightningBolt, 2)

func Gathering_Storm_Clouds():
	if classAbility(GameData.Classes.RANGED):
		$"../PlayerHand".drawCard()

func Spinning_Cyclone():
	var c = []
	for i in $"../City".city:
		if i:
			c.append(i)
	if c == []:
		return
	var h = await $"../BlackScreen".customCardChoices(0, 1, "Move", c, true, "Choose villain to move")
	if h == []:
		return
	h = h[0]
	
	if h.bystanders.size() > 0:
		h.removeExtraText("Bystanders")
	while h.bystanders.size() > 0:
		$"../PlayerHand".vicPile.append(h.rescueBystander())
	
	var ind = $"../City".city.find(h)
	$"../ModifierManager".removeCityPosition(ind)
	$"../City".city[ind] = null
	var moveFunc = func(card, l, prevInd):
		if $"../City".city[l]:
			$"../ModifierManager".removeCityPosition(l)
			$"../City".city[prevInd] = $"../City".city[l]
			$"../City".city[prevInd].position = $"../City".calcCardPosition(prevInd)
			$"../ModifierManager".removeCityPosition(prevInd)
		$"../City".city[l] = card
		card.position = $"../City".calcCardPosition(l)
		$"../ModifierManager".applyCityPosition(l)
	
	var sewersMove = func():
		moveFunc.call(h, 0, ind)
		emit_signal("finishCustom")
	var bankMove = func():
		moveFunc.call(h, 1, ind)
		emit_signal("finishCustom")
	var rooftopsMove = func():
		moveFunc.call(h, 2, ind)
		emit_signal("finishCustom")
	var streetsMove = func():
		moveFunc.call(h, 3, ind)
		emit_signal("finishCustom")
	var bridgeMove = func():
		moveFunc.call(h, 4, ind)
		emit_signal("finishCustom")
	
	var funcs = [sewersMove, bankMove, rooftopsMove, streetsMove, bridgeMove]
	var text = ["Sewers", "Bank", "Rooftops", "Streets", "Bridge"]
	funcs.remove_at(ind)
	text.remove_at(ind)
	
	await $"../BlackScreen".customChoices(text, funcs, null, "Choose city spot to move/swap card")
	if $"../..".playerCount > 1:
		$"../..".socket.send_text(str("CardEffect:Storm-Spinning Cyclone:", ind, ",", $"../City".city.find(h)))

func Spinning_Cyclone_aop(c):
	var one = int(c[0])
	var two = int(c[2])
	#if $"../City".city[one].bystanders.size() > 0:
		#$"../City".city[one].removeExtraText("Bystanders")
	while $"../City".city[one].bystanders.size() > 0:
		$"../City".city[one].rescueBystander()
	$"../ModifierManager".removeCityPosition(one)
	$"../ModifierManager".removeCityPosition(two)
	
	var temp = $"../City".city[one].position
	$"../City".city[one].position = $"../City".city[two].position
	$"../City".city[two].position = temp
	
	temp = $"../City".city[one]
	$"../City".city[one] = $"../City".city[two]
	$"../City".city[two] = temp
	$"../ModifierManager".applyCityPosition(one)
	$"../ModifierManager".applyCityPosition(two)

func Tidal_Wave():
	$"../ModifierManager".citySpotModifier($"../ModifierManager".TidalWaveBridge, 4)
	if classAbility(GameData.Classes.RANGED):
		$"../ModifierManager".createModifier($"../ModifierManager".TidalWaveMasterMind, $"../Mastermind")

# Thor

func Surge_of_Power():
	if res.totRecruit >= 8:
		print("Total Recruit: ", res.totRecruit)
		res.addAttack(3)

func Odinson():
	if classAbility(GameData.Classes.STRENGTH):
		res.addRecruit(2)

func Call_Lightning():
	if classAbility(GameData.Classes.RANGED):
		res.addAttack(3)

func God_of_Thunder():
	addCardEvent("God of Thunder")


# Gambit

func Stack_the_Deck():
	$"../PlayerHand".drawCard()
	$"../PlayerHand".drawCard()
	var r = await $"../BlackScreen".customCardChoices(1, 1, "Put on top of Deck", $"../PlayerHand".playerHand, true, "Choose card to put on top of your deck")
	if r:
		r = r[0]
		$"../PlayerHand".removeFromHand(r)
		$"../PlayerHand".deck.cards.push_front(r)
		$"../PlayerHand".updateDeckCount()
		r.position = Vector2(-312, 1612)

func Card_Shark():
	var c = $"../PlayerHand".deck.getTop(1)
	if c.identifier == "Hero" and c.team == GameData.Teams.XMEN:
		$"../PlayerHand".drawCard()


var gambitMutex = Mutex.new()
var gambitData = {}
var gambitDataCount = 1
signal updatedGambitData
func Hypnotic_Charm():
	var cAbil = classAbility(GameData.Classes.INSTINCT)
	var pList = $"../..".getOrderedPlayerList()
	gambitData[pList[0]] = $"../PlayerHand".deck.getTop(1)
	for i in range(1, pList.size()):
		gambitData[pList[i]] = null
	
	if $"../..".playerCount > 1 and cAbil:
		$"../..".socket.send_text("CardEffect:Gambit-Hypnotic Charm:,")
	
	var f1 = func():
		#$"../KODeck".addCards($"../PlayerHand".deck.draw())
		$"../PlayerHand".discardCard($"../PlayerHand".deck.draw())
		emit_signal("finishCustom")
	
	var f2 = func():
		emit_signal("finishCustom")
	
	await $"../BlackScreen".customChoices(["Discard", "Put back"], [f1, f2], $"../PlayerHand".deck.getTop(1), "Discard top card of deck or put it back")
	
	if cAbil:
		while gambitDataCount < pList.size():
			await updatedGambitData
		
		for i in pList:
			#print(i)
			if i == $"..".username:
				continue
			if !gambitData[i]:
				continue
			f1 = func():
				$"../..".socket.send_text(str("CardEffect:Gambit-Hypnotic Charm:,,", i))
				emit_signal("finishCustom")
			var card = GameData.generateCardFromCode(gambitData[i])
			$"../PlayerHand".addCardToManager(card)
			await $"../BlackScreen".customChoices(["Discard", "Put back"], [f1, f2], card, str("Discard top card of deck for ", i, " or put it back"))
			card.queue_free()
		gambitData = {}
		gambitDataCount = 1

func Hypnotic_Charm_aop(choice: String):
	# Requesting data to be sent
	if choice == ",":
		var c = $"../PlayerHand".deck.getTop(1)
		if !c:
			return
		var code = str($"..".username, ",", GameData.getCardCode(c))
		$"../..".socket.send_text(str("CardEffect:Gambit-Hypnotic Charm:,", code))
	# Requesting card to get KO'd
	elif choice.begins_with(",,") and choice.substr(2, -1) == $"..".username:
		$"../PlayerHand".discardCard($"../PlayerHand".deck.draw())
	# Receiveing card data
	elif choice[1] != "," and $"..".yourTurn:
		var uname = choice.substr(1, choice.find(",", 1) - 1)
		var code = choice.substr(choice.find(",", 1) + 1, -1)
		call_deferred("editGambitData", uname, code)

func editGambitData(key, value):
	gambitMutex.lock()
	gambitData[key] = value
	gambitDataCount += 1
	gambitMutex.unlock()

func High_Stakes_Jackpot():
	var c = $"../PlayerHand".deck.getTop(1)
	if c.cost > 0:
		res.addAttack(c.cost)

# Deadpool

func HoldThis_ForaSecond():
	var v = []
	for i in $"../City".city:
		if i:
			v.append(i)
	if v.size() > 0:
		var r = await $"../BlackScreen".customCardChoices(1, 1, "Capture bystander", v, false, "Choose Villain to capture bystander")
		r = r[0]
		r.captureBystander($"../Bystanders".draw())

func Oddball():
	var nums = []
	for i in $"../PlayerHand".played:
		if i != $"../PlayerHand".played[-1] and i.identifier == "Hero" and i.cost % 2 == 1 and i.cost not in nums:
			nums.append(i.cost)
	res.addAttack(nums.size())

func CanIGetADoover():
	if $"../PlayerHand".played.size() == 1:
		var f1 = func():
			var id = 0
			while id < $"../PlayerHand".playerHand.size():
				var olds = $"../PlayerHand".playerHand.size()
				$"../PlayerHand".discardCard($"../PlayerHand".playerHand[0])
				if olds == $"../PlayerHand".playerHand.size():
					id += 1
			$"../PlayerHand".drawCard()
			$"../PlayerHand".drawCard()
			$"../PlayerHand".drawCard()
			$"../PlayerHand".drawCard()
			emitCustomSignalEnd()
		var f2 = func():
			emitCustomSignalEnd()
		await $"../BlackScreen".customChoices(["Discard Hand", "Keep Hand"], [f1, f2], $"../PlayerHand".played[0], "Choose: Discard hand and draw 4 cards or do nothing")

func Random_Acts_of_Unkindness():
	var f1 = func():
		#$"../PlayerHand".addWound(1)
		$"../PlayerHand".addCardToHand($"../Wounds".draw())
		emitCustomSignalEnd()
	var f2 = func():
		emitCustomSignalEnd()
	await $"../BlackScreen".customChoices(["Gain Wound", "Do Nothing"], [f1, f2], null, "Choose: Add wound to hand or do nothing")
	
	if $"../..".playerCount > 1:
		$"../..".socket.send_text("CardEffect:Deadpool-Random Acts of Unkindness:,")
		await Random_Acts_of_Unkindness_aop(",")

var RAOU_data = null
signal raouReceived
func Random_Acts_of_Unkindness_aop(choice: String):
	var pList = $"../..".getOrderedPlayerList()
	# Request to send
	if choice == ",":
		$"../BlackScreen".toggleLockCheck()
		var r = await $"../BlackScreen".customCardChoices(1, 1, "Send", $"../PlayerHand".playerHand, true, "Choose card to give to next player in line")
		$"../BlackScreen".toggleLockCheck()
		if r:
			$"../PlayerHand".removeFromHand(r[0])
			r[0].position = Vector2(-300, 300)
			var c = GameData.getCardCode(r[0])
			$"../..".socket.send_text(str("CardEffect:Deadpool-Random Acts of Unkindness:", pList[1], ",", c))
		else:
			#print("Not R")
			$"../..".socket.send_text(str("CardEffect:Deadpool-Random Acts of Unkindness:", pList[1], ",0"))
		if RAOU_data == null:
			await raouReceived
		#print(RAOU_data)
		if !RAOU_data.is_class("String"):
			#print($"../..".username, " received ", RAOU_data.identifier)
			$"../PlayerHand".addCardToHand(RAOU_data)
			
	# Received data
	elif choice.begins_with($"../..".username):
		var data = choice.substr(choice.find(",") + 1, -1)
		if data == "0":
			data = "0"
		else:
			#print($"../..".username, "recieved ", data)
			data = GameData.generateCardFromCode(data)
			$"../CardManager".add_child(data)
		RAOU_data = data
		emit_signal("raouReceived")


# Rogue

func Energy_Drain():
	if classAbility(GameData.Classes.COVERT):
		var r = await $"../BlackScreen".chooseCardKO(0, 1, ["hand", "discard"], null, "KO 0 or 1 card from hand and discard. If KO'd, gain 1 recruit")
		if r:
			res.addRecruit(1)

func Borrowed_Brawn():
	if classAbility(GameData.Classes.STRENGTH):
		res.addAttack(3)

func Copy_Powers():
	var cardChoices = $"../PlayerHand".played.slice(1, $"../PlayerHand".played.size())
	var r = await $"../BlackScreen".customCardChoices(1, 1, "Copy", cardChoices, false, "Choose card to play a copy of")
	if r:
		var card = r[0]
		if card.hClass != GameData.Classes.COVERT:
			$"../PlayerHand".cardBeingPlayed.secondaryClasses.append(card.hClass)
		await $"../PlayerHand".playCard(card, true)

func Steal_Abilities():
	if $"../..".playerCount > 1:
		$"../..".socket.send_text("CardEffect:Rogue-Steal Abilities:,")
	
	var pList = $"../..".getOrderedPlayerList()
	SA_data[pList[0]] = $"../PlayerHand".deck.getTop(1)
	for i in range(1, pList.size()):
		SA_data[pList[i]] = null
	$"../PlayerHand".discardCard($"../PlayerHand".deck.draw())
	await get_tree().create_timer(.2).timeout
	if saDataCount < $"../..".playerCount:
		print("Awaiting")
		await saReceived
	
	var c = []
	print(SA_data)
	for i in SA_data.keys():
		if i == $"../..".username:
			c.append(SA_data[i])
		else:
			c.append(GameData.generateCardFromCode(SA_data[i]))
			$"../CardManager".add_child(c[-1])
	
	await $"../BlackScreen".customChoicesWithCards(["Confirm"], [emitCustomSignalEnd], c, "Cards being played in order")
	
	for i in c:
		await $"../BlackScreen".customChoices(["Play"], [emitCustomSignalEnd], i, "Next card to play")
		await $"../PlayerHand".playCard(i, true)

var rogueMutex = Mutex.new()
var SA_data = {}
var saDataCount = 1
signal saReceived
func Steal_Abilities_aop(choice: String):
	# Requesting data to be sent
	if choice == ",":
		var c = $"../PlayerHand".deck.getTop(1)
		if !c:
			return
		
		var code = str($"..".username, ",", GameData.getCardCode(c))
		$"../..".socket.send_text(str("CardEffect:Rogue-Steal Abilities:,", code))
		$"../PlayerHand".discardCard($"../PlayerHand".deck.draw())
	# Requesting card to get KO'd
	elif $"..".yourTurn:
		var uname = choice.substr(1, choice.find(",", 1) - 1)
		var code = choice.substr(choice.find(",", 1) + 1, -1)
		print("Updating: ", uname, " ", code)
		call_deferred("editRogueData", uname, code)
		if saDataCount == $"../..".playerCount:
			print("Emitting")
			saReceived.emit()

func editRogueData(key, value):
	rogueMutex.lock()
	SA_data[key] = value
	saDataCount += 1
	rogueMutex.unlock()
# General funcs

func effect(card, args=[]):
	var s = card.getFuncName()
	if args.size() > 0:
		return await links[s].call(args)
	else:
		return await links[s].call()

func emitCustomSignalEnd():
	emit_signal("finishCustom")

func addCardEvent(event):
	if event in $"../PlayerHand".eventCards:
		$"../PlayerHand".eventCards[event] += 1
	else:
		$"../PlayerHand".eventCards[event] = 1

func classAbility(c, count=1):
	return $"../PlayerHand".classCount(c, true, false) >= count

func prereq(card, args=[]):
	for i in prereqs:
		if i == card.getFuncName():
			if args.size() > 0:
				return await prereqs[i].call(args)
			else:
				return await prereqs[i].call()
	return true

func woundFilter(c) :
	return c.identifier == "Wound"

func heroFilter(c):
	return c.identifier == "Hero"
	
func sixCostFilter(c):
	return c.cost <= 6

func shieldFilter(c):
	return heroFilter(c) and c.team == GameData.Teams.SHIELD

func nullFunc():
	return true
	

















var villain_prereqs = {
	"Spider Foes-Venom" : Venom_prereq,
	"Brotherhood-Blob" : Blob_prereq
}

var villain_ambush = {
	"Spider Foes-Green Goblin" : GreenGoblin_ambush,
	"Radiation-The Leader" : TheLeader_ambush,
	"Brotherhood-Juggernaut" : Juggernaut_ambush,
	"Enemies of Asgard-Ymir, Frost Giant King" : Ymir_ambush,
	"Skrulls-Skrull Shapeshifters" : SkrullShapeshifters_ambush,
	"Skrulls-Skrull Queen Veranke" : QueenVeranke_ambush,
}

var villain_fight = {
	"Henchmen-Sentinel" : Sentinel_Fight,
	"Henchmen-Hand Ninja" : HandNinja_Fight,
	"Henchmen-Doombot Legion" : DoombotLegion_fight,
	"Henchmen-Savage Land Mutates" : SavageLandMutates_fight,
	"HYDRA-Endless Armies of Hydra" : Endless_Armies_Hydra_fight,
	"HYDRA-Viper" : Viper_fight_esc,
	"HYDRA-Hydra Kidnappers" : Kidnapper_fight,
	"Spider Foes-Doctor Octopus" : DocOc_fight,
	"Spider Foes-The Lizard" : Lizard_fight,
	"Radiation-Abomination" : Abomination_fight,
	"Radiation-Maestro" : Maestro_fight,
	"Radiation-Zzzax" : Zzzax_fight_esc,
	"Brotherhood-Sabretooth" : Sabretooth_fight_esc,
	"Enemies of Asgard-Frost Giant" : FrostGiant_fight_esc,
	"Enemies of Asgard-Destroyer" : Destroyer_fight,
	"Enemies of Asgard-Enchantress" : Enchantress_fight,
	"Enemies of Asgard-Ymir, Frost Giant King" : Ymir_fight,
	"Skrulls-Super-Skrull" : SuperSkrull_fight,
	"Skrulls-Skrull Shapeshifters" : SkrullShapeshifters_fight,
	"Skrulls-Skrull Queen Veranke" : QueenVeranke_fight,
	"Skrulls-Paibok the Power Skrull" : Paibok_fight,
	"Masters of Evil-Whirlwind" : Whirlwind_fight,
	"Masters of Evil-Baron Zemo" : BaronZemo_fight,
	"Masters of Evil-Melter" : Melter_fight
}

var villain_escape = {
	"HYDRA-Viper" : Viper_fight_esc,
	"Spider Foes-Venom" : Venom_esc,
	"Radiation-Zzzax" : Zzzax_fight_esc,
	"Brotherhood-Juggernaut" : Juggernaut_esc,
	"Brotherhood-Mystique" : Mystique_esc,
	"Brotherhood-Sabretooth" : Sabretooth_fight_esc,
	"Enemies of Asgard-Frost Giant" : FrostGiant_fight_esc,
	"Enemies of Asgard-Destroyer" : Destroyer_esc,
	"Masters of Evil-Ultron" : Ultron_esc
}

var villain_aopfight = {
	"HYDRA-Endless Armies of Hydra" : Endless_Armies_Hydra_fight,
	"HYDRA-Viper" : Viper_fight_esc,
	"Spider Foes-The Lizard" : Lizard_fight,
	"Radiation-Zzzax" : Zzzax_fight_esc,
	"Brotherhood-Sabretooth" : Sabretooth_fight_esc,
	"Enemies of Asgard-Frost Giant" : FrostGiant_fight_esc,
	"Skrulls-Super-Skrull" : SuperSkrull_fight
}

func Sentinel_Fight():
	await $"../BlackScreen".chooseCardKO(1, 1, ["hand", "played"], heroFilter, "KO 1 Hero from hand or played cards")

func HandNinja_Fight():
	res.addRecruit(1)

func DoombotLegion_fight():
	await $"../BlackScreen".KOFromDeck(1, 1, 2, "KO 1 of the top 2 cards of your deck")

func SavageLandMutates_fight():
	$"../PlayerHand".handSize += 1



func Endless_Armies_Hydra_fight():
	await $"../City".drawVilCard()
	await $"../City".drawVilCard()

func Viper_fight_esc():
	for i in $"../PlayerHand".vicPile:
		if i.identifier == "Villain" and i.team == "HYDRA":
			return true
	await $"../PlayerHand".addWound(1)
	return true

func Kidnapper_fight():
	if $"../HQ".officerCount > 0:
		var f1 = func():
			$"../HQ".addOfficer()
			emit_signal("finishCustom")
			
		var f2 = func():
			emit_signal("finishCustom")
			
		await $"../BlackScreen".customChoices(["Add Officer", "Nothing"], [f1, f2], $"../HQ".displayOfficer)

func DocOc_fight():
	$"../PlayerHand".handSize += 2

func GreenGoblin_ambush():
	var v = $"../City".addedVil
	var b = $"../Bystanders".draw()
	if b:
		v.captureBystander(b)

func Lizard_fight():
	#print("Liz fight, ", $"..".yourTurn)
	var ind = $"../City".focused
	if ind == 0:
		if !$"..".yourTurn:
			$"../PlayerHand".addWound(1)

func Venom_prereq():
	return $"../PlayerHand".classCount(GameData.Classes.COVERT, false, true) > 0

func Venom_esc():
	$"../PlayerHand".addWound(1)

func Abomination_fight():
	var ind = $"../City".focused
	if ind == 4 or ind == 3:
		hand.saveBystander()
		hand.saveBystander()
		hand.saveBystander()

func TheLeader_ambush():
	await $"../City".drawVilCard()

func Maestro_fight():
	var count = $"../PlayerHand".classCount(GameData.Classes.STRENGTH, false, true)
	if count > 0:
		await $"../BlackScreen".chooseCardKO(count, count, ["hand", "played"], heroFilter, str("KO ", count, " heroes from hand and played"))

func Zzzax_fight_esc():
	var count = $"../PlayerHand".classCount(GameData.Classes.STRENGTH, false, true)
	if count == 0:
		await $"../PlayerHand".addWound(1)

func Blob_prereq():
	return $"../PlayerHand".teamCount(GameData.Teams.XMEN, false, true) > 0

func Juggernaut_ambush():
	$"../BlackScreen".toggleLockCheck()
	await $"../BlackScreen".chooseCardKO(2, 2, ["discard"], heroFilter, "KO 2 heroes from discard pile")
	$"../BlackScreen".toggleLockCheck()

func Juggernaut_esc():
	$"../BlackScreen".toggleLockCheck()
	await $"../BlackScreen".chooseCardKO(2, 2, ["hand"], heroFilter, "KO 2 heroes from hand")
	$"../BlackScreen".toggleLockCheck()

func Mystique_esc():
	await $"../Scheme".twist()

func Sabretooth_fight_esc():
	if $"../PlayerHand".teamCount(GameData.Teams.XMEN, false, true) == 0:
		$"../PlayerHand".addWound(1)

func FrostGiant_fight_esc():
	if $"../PlayerHand".classCount(GameData.Classes.RANGED, false, true) == 0:
		await $"../PlayerHand".addWound(1)

func Destroyer_fight():
	var p = 0
	
	while p < $"../PlayerHand".playerHand.size():
		if $"../PlayerHand".playerHand[p].identifier == "Hero" and $"../PlayerHand".playerHand[p].team == GameData.Teams.SHIELD:
			$"../KODeck".addCards($"../PlayerHand".playerHand[p])
			$"../PlayerHand".playerHand[p].position = Vector2(-500, -500)
			$"../PlayerHand".deleteCard($"../PlayerHand".playerHand[p])
			await $"../PlayerHand".updateHandPositions()
		else:
			p += 1
	
	for i in $"../PlayerHand".played:
		if i.identifier == "Hero" and i.team == GameData.Teams.SHIELD:
			$"../KODeck".addCards(i)

func Destroyer_esc():
	$"../BlackScreen".toggleLockCheck()
	await $"../BlackScreen".chooseCardKO(2, 2, ["hand", "played"], heroFilter, "KO 2 cards from hand and played cards")
	$"../BlackScreen".toggleLockCheck()

func Enchantress_fight():
	$"../PlayerHand".drawCard()
	$"../PlayerHand".drawCard()
	$"../PlayerHand".drawCard()

func Ymir_ambush():
	if $"../PlayerHand".classCount(GameData.Classes.RANGED, false, true) == 0:
		await $"../PlayerHand".addWound(1)

func Ymir_fight():
	var c = await $"../BlackScreen".choosePlayerName(false, false, "Choose player to KO wounds from hand/discard pile")
	if c == $"../..".username:
		Ymir_fight_aop(c)
	else:
		$"../..".socket.send_text(str("CardEffect:Enemies of Asgard-Ymir, Frost Giant King:", c))

func Ymir_fight_aop(choice):
	if choice == $"../..".username:
		print(choice, " picked me")
		$"../BlackScreen".toggleLockCheck()
		await $"../BlackScreen".chooseCardKO(0, 0, ['hand', "discard"], woundFilter, "KO any number of wounds from hand and discard pile")
		$"../BlackScreen".toggleLockCheck()
	else:
		print(choice, " not me")

func SuperSkrull_fight():
	$"../BlackScreen".toggleLockCheck()
	await $"../BlackScreen".chooseCardKO(1, 1, ["hand", "played"], heroFilter, "KO a hero from your hand or played cards")
	$"../BlackScreen".toggleLockCheck()

func SkrullShapeshifters_ambush():
	var v = $"../City".addedVil
	var hero = $"../HQ".hq[0]
	v.attack = hero.cost
	v.addExtraText(str("Held Card: ", hero.getFuncName()), "SkrullVil1")
	v.addExtraText(str("Attack: ", v.attack), "SkrullVil2")
	v.extraData = hero
	hero.position = Vector2(-626, 114)
	$"../HQ".hq[0] = null
	$"../HQ".fillHQ()

func SkrullShapeshifters_fight():
	$"../PlayerHand".deck.discardCard($"../City".foughtVil.extraData)

func QueenVeranke_ambush():
	var ind = 0
	var v = $"../City".addedVil
	var hero = $"../HQ".hq[0]
	for i in range(1, 5):
		if $"../HQ".hq[i].cost > hero.cost:
			hero = $"../HQ".hq[i]
			ind = i
	v.attack = hero.cost
	v.addExtraText(str("Held Card: ", hero.getFuncName()), "SkrullVil1")
	v.addExtraText(str("Attack: ", v.attack), "SkrullVil2")
	v.extraData = hero
	hero.position = Vector2(-626, 114)
	$"../HQ".hq[ind] = null
	$"../HQ".fillHQ()

func QueenVeranke_fight():
	$"../PlayerHand".deck.discardCard($"../City".foughtVil.extraData)

func Paibok_fight():
	var pl = $"../..".getOrderedPlayerList()
	for i in pl:
		var r = await $"../BlackScreen".customCardChoices(1, 1, i, $"../HQ".hq, true, str("Choose card to recruit for ", i))
		r = r[0]
		var ind = $"../HQ".hq.find(r)
		var payload = str(i, ",", ind)
		if i == $"..".username:
			await Paibok_fight_aop(payload)
		else:
			$"../..".recruitIgnores += 1
			var msg = str("CardEffect:Skrulls-Paibok the Power Skrull:", payload)
			$"../..".socket.send_text(msg)

func Paibok_fight_aop(choice: String):
	#print("Payload Received: ", choice)
	var uname = choice.substr(0, choice.find(","))
	if uname == $"..".username:
		var ind = int(choice[-1])
		var c = $"../HQ".hq[ind]
		$"../HQ".hq[ind] = null
		$"../PlayerHand".deck.discardCard(c)
		$"../HQ".fillHQ()
		if $"..".PLAYER_COUNT > 1:
			$"../..".socket.send_text(str("Recruited:", ind))

func Ultron_esc():
	if $"../PlayerHand".classCount(GameData.Classes.TECH, false, true) == 0:
		await $"../PlayerHand".addWound(1)

func Whirlwind_fight():
	if $"../City".focused == 2 or $"../City".focused == 4:
		await $"../BlackScreen".chooseCardKO(2, 2, ["hand", "played"], heroFilter, "KO 2 heros from your hand or played cards")

func BaronZemo_fight():
	var c = $"../PlayerHand".teamCount(GameData.Teams.AVENGERS, false, true)
	for i in c:
		$"../PlayerHand".saveBystander()


var melterMutex = Mutex.new()
var melterData = {}
var dataCount = 1
signal updatedMelterData

func Melter_fight():
	var pList = $"../..".getOrderedPlayerList()
	melterData[pList[0]] = $"../PlayerHand".deck.getTop(1)
	for i in range(1, pList.size()):
		melterData[pList[i]] = null
	
	if $"../..".playerCount > 1:
		$"../..".socket.send_text("CardEffect:Masters of Evil-Melter:,")
	
	var f1 = func():
		$"../KODeck".addCards($"../PlayerHand".deck.draw())
		emit_signal("finishCustom")
	
	var f2 = func():
		emit_signal("finishCustom")
	
	await $"../BlackScreen".customChoices(["KO", "Put back"], [f1, f2], $"../PlayerHand".deck.getTop(1), "KO top card of deck or put it back")
	
	while dataCount < pList.size():
		await updatedMelterData
	
	for i in pList:
		#print(i)
		if i == $"..".username:
			continue
		#melterMutex.lock()
		if !melterData[i]:
			#print("No data found")
			#print("Main dict: ", melterData)
			continue
		f1 = func():
			$"../..".socket.send_text(str("CardEffect:Masters of Evil-Melter:,,", i))
			emit_signal("finishCustom")
		var card = GameData.generateCardFromCode(melterData[i])
		$"../PlayerHand".addCardToManager(card)
		await $"../BlackScreen".customChoices(["KO", "Put back"], [f1, f2], card, str("KO top card of deck or put it back for ", i))
		card.queue_free()
		melterData = {}
		dataCount = 1

# Send request as ,
# Send card data as ,username,12,0
# Send ko data as ,,
func Melter_fight_aop(choice: String):
	# Requesting data to be sent
	if choice == ",":
		var c = $"../PlayerHand".deck.getTop(1)
		if !c:
			return
		var code = str($"..".username, ",", GameData.getCardCode(c))
		$"../..".socket.send_text(str("CardEffect:Masters of Evil-Melter:,", code))
	# Requesting card to get KO'd
	elif choice.begins_with(",,") and choice.substr(2, -1) == $"..".username:
		$"../KODeck".addCards($"../PlayerHand".deck.draw())
	# Receiveing card data
	elif choice[1] != "," and $"..".yourTurn:
		var uname = choice.substr(1, choice.find(",", 1) - 1)
		var code = choice.substr(choice.find(",", 1) + 1, -1)
		call_deferred("editMelterData", uname, code)

func editMelterData(key, value):
	melterMutex.lock()
	melterData[key] = value
	dataCount += 1
	melterMutex.unlock()















var mastermind_strikes = {
	"Mastermind-Red Skull" : Red_Skull_Strike,
	"Mastermind-Dr. Doom" : DrDoom_strike,
	"Mastermind-Magneto" : Magneto_strike,
	"Mastermind-Loki" : Loki_strike
}

func Red_Skull_Strike():
	$"../BlackScreen".toggleLockCheck()
	await $"../BlackScreen".chooseCardKO(1, 1, ["hand"], heroFilter, "KO a hero from your hand")
	$"../BlackScreen".toggleLockCheck()

func DrDoom_strike():
	if $"../PlayerHand".playerHand.size() == 6:
		if $"../PlayerHand".classCount(GameData.Classes.TECH, false, true) == 0:
			$"../BlackScreen".toggleLockCheck()
			$"../BlackScreen".addLockSkip(1)
			var c = await $"../BlackScreen".customCardChoices(1, 1, "Put on top of deck", $"../PlayerHand".playerHand, true, "Put 1 card on top of deck (Chosen twice)")
			if c:
				c = c[0]
				$"../PlayerHand".removeFromHand(c)
				c.position = Vector2(111, -514)
				$"../PlayerHand".deck.cards.push_front(c)
				$"../PlayerHand".updateDeckCount()
				c = await $"../BlackScreen".customCardChoices(1, 1, "Put on top of deck", $"../PlayerHand".playerHand, "Put 1 card on top of deck (Chosen twice)")
				$"../BlackScreen".toggleLockCheck()
				if c:
					c = c[0]
					$"../PlayerHand".removeFromHand(c)
					c.position = Vector2(111, -514)
					$"../PlayerHand".deck.cards.push_front(c)
					$"../PlayerHand".updateDeckCount()

func Magneto_strike():
	if $"../PlayerHand".teamCount(GameData.Teams.XMEN, false, true) == 0:
		var dCount = $"../PlayerHand".playerHand.size() - 4
		$"../BlackScreen".toggleLockCheck()
		await $"../BlackScreen".chooseCardDiscard(dCount, dCount, false, str("Discard ", dCount, " cards from hand"))
		$"../BlackScreen".toggleLockCheck()

func Loki_strike():
	if $"../PlayerHand".classCount(GameData.Classes.STRENGTH, false, true) == 0:
		$"../PlayerHand".addWound(1)

var mastermind_prereqs = {
	
}

var tactic_fight = {
	"Red Skull-Endless Resources" : Endless_Resources,
	"Red Skull-Hydra Conspiracy" : Hydra_Conspiracy,
	"Red Skull-Negablast Grenades" : Negablast_Grenades,
	"Red Skull-Ruthless Dictator" : Ruthless_Dictator,
	"Dr. Doom-Treasures of Latveria" : Treasures_of_Latveria,
	"Dr. Doom-Dark Technology" : Dark_Technology,
	"Dr. Doom-Secrets of Time Travel" : Secrets_of_Time_Travel,
	"Dr. Doom-Monarch's Decree" : Monarchs_Decree,
	"Magneto-Bitter Captor" : Bitter_Captor,
	"Magneto-Crushing Shockwave" : Crushing_Shockwave,
	"Magneto-Electromagnetic Bubble" : Electromagnetic_Bubble,
	"Magneto-Xavier's Nemesis" : Xaviers_Nemesis,
	"Loki-Cruel Ruler" : Cruel_Ruler,
	"Loki-Maniacal Tyrant" : Maniacal_Tyrant,
	"Loki-Vanishing Illusions" : Vanishing_Illusions,
	"Loki-Whispers and Lies" : Whispers_and_Lies
}


# Red Skull


func Endless_Resources():
	res.addRecruit(4)

func Hydra_Conspiracy():
	hand.drawCard()
	hand.drawCard()
	for i in $"../PlayerHand".vicPile:
		if i.identifier == "Villain" and i.team == "HYDRA":
			hand.drawCard()

func Negablast_Grenades():
	res.addAttack(3)

func Ruthless_Dictator():
	await $"../BlackScreen".KOFromDeck(1, 1, 3, "KO 1 card from top 3 cards of deck, then discard 1 card from top 2 cards of deck")
	await $"../BlackScreen".discardFromDeck(1, 1, 2)


# Dr Doom


func Treasures_of_Latveria():
	$"../PlayerHand".handSize += 3

func Dark_Technology():
	var h = $"../HQ".hq
	var choices = []
	for i in h:
		if i.isClass(GameData.Classes.TECH) or i.isClass(GameData.Classes.RANGED):
			choices.append(i) 
	var c = await $"../BlackScreen".customCardChoices(0, 1, "Recruit", choices, true, "Recruit Tech or Ranged hero for free")
	if c:
		c = c[0]
		var ind = $"../HQ".hq.find(c)
		$"../HQ".hq[ind] = null
		$"../PlayerHand".deck.discardCard(c)
		$"../HQ".fillHQ()
		if $"..".PLAYER_COUNT > 1:
			$"../..".socket.send_text(str("Recruited:", ind))

func Secrets_of_Time_Travel():
	$"../PlayerHand".extraTurn += 1

func Monarchs_Decree():
	if $"../..".playerCount > 1:
		var f1 = func():
			#$"../PlayerHand".drawCard()
			if $"../..".playerCount > 1:
				$"../..".socket.send_text("CardEffect:Dr. Doom-Monarch's Decree:1")
			emit_signal("finishCustom")
			
		var f2 = func():
			if $"../..".playerCount > 1:
				$"../..".socket.send_text("CardEffect:Dr. Doom-Monarch's Decree:2")
			#$"../BlackScreen".disappear()
			#$"../BlackScreen".deleteCustomButtons()
			#await $"../BlackScreen".chooseCardDiscard(1, 1)
			emit_signal("finishCustom")
			
		await $"../BlackScreen".customChoices(["Draw", "Discard"], [f1, f2], null, "Choose: All other players draw a card or discard a card")

func Monarchs_Decree_aop(choice):
	if choice == "1":
		$"../PlayerHand".drawCard()
	else:
		$"../BlackScreen".toggleLockCheck()
		await $"../BlackScreen".chooseCardDiscard(1, 1)
		$"../BlackScreen".toggleLockCheck()


# Magneto


func Bitter_Captor():
	var h = $"../HQ".hq
	var choices = []
	for i in h:
		if i.team == GameData.Teams.XMEN:
			choices.append(i) 
	var c = await $"../BlackScreen".customCardChoices(0, 1, "Recruit", choices, true, "Recruit an X-MEN hero for free")
	if c:
		c = c[0]
		var ind = $"../HQ".hq.find(c)
		$"../HQ".hq[ind] = null
		$"../PlayerHand".deck.discardCard(c)
		$"../HQ".fillHQ()
		if $"..".PLAYER_COUNT > 1:
			$"../..".socket.send_text(str("Recruited:", ind))

func Crushing_Shockwave():
	if $"../..".playerCount > 1:
		$"../..".socket.send_text("CardEffect:Magneto-Crushing Shockwave:1")

func Crushing_Shockwave_aop(choice):
	assert(int(choice) == 1)
	if $"../PlayerHand".teamCount(GameData.Teams.XMEN, false, true) == 0:
		$"../PlayerHand".addWound(2)

func Electromagnetic_Bubble():
	var c = []
	for i in $"../PlayerHand".playerHand:
		if i.team == GameData.Teams.XMEN:
			c.append(i)
	for i in $"../PlayerHand".played:
		if i.team == GameData.Teams.XMEN:
			c.append(i)
	var choice = await $"../BlackScreen".customCardChoices(1, 1, "Holdover", c, true, "Choose X-MEN card to put in hand next turn")
	if choice:
		choice = choice[0]
		$"../PlayerHand".holdoverCard(choice)

func Xaviers_Nemesis():
	var count = $"../PlayerHand".teamCount(GameData.Teams.XMEN, false, true)
	for i in range(count):
		$"../PlayerHand".saveBystander()



# Loki

func Cruel_Ruler():
	var c = []
	for i in $"../City".city:
		if i and i.identifier == "Villain":
			c.append(i)
	if c.size() > 0:
		var r = await $"../BlackScreen".customCardChoices(1, 1, "Defeat", c, true, "Defeat a villain in the city for free")
		r = r[0]
		await $"../City"._on_fight_button_down($"../City".city.find(r))

func Maniacal_Tyrant():
	await $"../BlackScreen".chooseCardKO(0, 4, ["discard"], null, "KO up to 4 cards from your discard pile")

func Vanishing_Illusions():
	if $"../..".playerCount > 1:
		$"../..".socket.send_text("CardEffect:Loki-Vanishing Illusions:1")

func Vanishing_Illusions_aop(choice):
	assert(choice)
	var choices = []
	for i in $"../PlayerHand".vicPile:
		if i.identifier == "Villain":
			choices.append(i)
	$"../BlackScreen".toggleLockCheck()
	var c = await $"../BlackScreen".customCardChoices(1, 1, "KO", choices, true, "KO villain from your VP pile")
	$"../BlackScreen".toggleLockCheck()
	if c:
		c = c[0]
		c.position = Vector2(114, -437)
		$"../PlayerHand".vicPile.erase(c)
		$"../KODeck".addCards(c)

func Whispers_and_Lies():
	if $"../..".playerCount > 1:
		$"../..".socket.send_text("CardEffect:Loki-Whispers and Lies:1")

func Whispers_and_Lies_aop(choice):
	assert(choice)
	var choices = []
	for i in $"../PlayerHand".vicPile:
		if i.identifier == "Bystander":
			choices.append(i)
	$"../BlackScreen".toggleLockCheck()
	var c = await $"../BlackScreen".customCardChoices(2, 2, "KO", choices, true, "KO 2 bystanders from your VP pile")
	$"../BlackScreen".toggleLockCheck()
	for i in c:
		$"../PlayerHand".vicPile.erase(i)
		$"../KODeck".addCards(i)
		i.position = Vector2(114, -437)













var SchemeTwistLinks = {
	"Unleash the Power of the Cosmic Cube" : PowerCosmicCube_twist,
	"The Legacy Virus" : LegacyVirus_twist,
	"Negative Zone Prison Breakout" : NegativeZoneBreakout_twist,
	"Super Hero Civil War" : SuperHeroCivilWar_twist,
	"Portals to the Dark Dimension" : PortalsDarkDimenstion_twist,
	"Midtown Bank Robbery" : MidtownBankRobbery_twist,
	"Replace Earth's Leaders with Killbots" : LeaderKillbot_twist,
	"Secret Invasion of the Skrull Shapeshifters" : SecretInvasionSkrull_twist
}

var SchemeSetupLinks = {
	"The Legacy Virus" : LegacyVirus_setup,
	"Super Hero Civil War" : SuperHeroCivilWar_setup
}


# Schemes have other setup funcs and twist funcs

func PowerCosmicCube_twist(t : int):
	if t == 5 or t == 6:
		await $"../PlayerHand".addWound(1)
		#$"../PlayerHand".deck.updateDiscardCount()
	elif t == 7:
		await $"../PlayerHand".addWound(3)
		#$"../PlayerHand".deck.updateDiscardCount()
	elif t == 8:
		$"..".lose()

func LegacyVirus_setup():
	$"../Scheme".overrides["Wounds"] = 6 * $"../..".playerCount

func LegacyVirus_twist(t : int):
	assert(t > 0)
	if $"../PlayerHand".classCount(GameData.Classes.TECH, false, true) == 0:
		await $"../PlayerHand".addWound(1)

func NegativeZoneBreakout_twist(t : int):
	assert(t > 0)
	await $"../City".drawVilCard()
	await $"../City".drawVilCard()

func SuperHeroCivilWar_setup():
	if $"../..".playerCount > 3:
		$"../Scheme".twistCount = 5

func SuperHeroCivilWar_twist(t: int):
	assert(t > 0)
	for i in range(5):
		await $"../HQ".KOhero($"../HQ".hq[i], false)

func PortalsDarkDimenstion_twist(t: int):
	if t == 1:
		$"../ModifierManager".createModifier($"../ModifierManager".DarkPortal, $"../Mastermind")
	elif t == 7:
		$"..".lose()
	else:
		$"../ModifierManager".citySpotModifier($"../ModifierManager".DarkPortal, 6 - t)

func MidtownBankRobbery_twist(t: int):
	assert (t>0)
	if $"../City".city[1]:
		var b = $"../Bystanders".draw()
		if b:
			$"../City".city[1].captureBystander(b)
			b = $"../Bystanders".draw()
			if b:
				$"../City".city[1].captureBystander(b)
	await $"../City".drawVilCard()

func LeaderKillbot_twist(t: int):
	for i in $"../Scheme".extraData:
		i.attack = t
		i.editExtraText(str("Killbot: ", t, " Attack"), "Killbot")

func SecretInvasionSkrull_twist(t: int):
	assert(t > 0)

	var hero = $"../HQ".hq[0]
	var ind = 0
	for i in range(1, 5):
		if $"../HQ".hq[i].cost > hero.cost:
			hero = $"../HQ".hq[i]
			ind = i
	
	hero.position = Vector2(-626, 114)
	$"../HQ".hq[ind] = null
	$"../HQ".fillHQ()
	
	var skrull = generateSkrull(hero)
	await $"../City".addToCity(skrull)

func generateSkrull(c):
	var vilScene = preload("res://Scenes/Villain.tscn")
	var v = vilScene.instantiate()
	$"../PlayerHand".addCardToManager(v)
	v.identifier = "Villain"
	v.team = "SecretSkrulls"
	v.attack = c.cost+2
	v.cardName = c.cardName
	v.vp = 0
	v.spritePath = c.spritePath
	v.initSprite(c.spritePath)
	v.position = Vector2(-519, 114)
	v.extraData = c
	v.addExtraText(str("Secret Skrull: ", v.attack, " Attack"), "Secret Skrull")
	return v
