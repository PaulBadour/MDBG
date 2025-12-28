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
	"Wolverine-Berserker Rage" : Berserker_Rage, # Some issue with drawing too many cards
	"Wolverine-Frenzied Slashing" : Frenzied_Slashing, # Some issue with drawing too many cards
	"Wolverine-Keen Senses" : Keen_Senses,
	"Wolverine-Healing Factor" : Healing_Factor,
	"Cyclops-XMen United" : XMen_United,
	"Cyclops-Determination" : nullFunc,
	"Cyclops-Optic Blast" : nullFunc,
	"Cyclops-Unending Energy" : nullFunc,
	"Hawkeye-Quick Draw" : Quick_Draw,
	"Hawkeye-Team Player" : Team_Player,
	"Hawkeye-Impossible Trick Shot" : Impossible_Trickshot,
	"Hawkeye-Covering Fire" : Covering_Fire
}

var prereqs = {
	"Cyclops-Determination" : Determination_prereq,
	"Cyclops-Optic Blast" : Optic_Blast_prereq
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
	var r = await $"../BlackScreen".chooseCardKO(0, 1, ["hand", "discard"], woundFilter)
	if r:
		hand.drawCard()
	return true

func Keen_Senses():
	if hand.classCount(GameData.Classes.INSTINCT):
		hand.drawCard()
	return true

# Cyclops

func Determination_prereq():
	var result = await $"../BlackScreen".chooseCardDiscard(1, 1)
	return result

func Optic_Blast_prereq():
	var result = await $"../BlackScreen".chooseCardDiscard(1, 1)
	return result

# This can actually just be null function, needs some functionality in the discard code
# Event - prevent discard
# Unending Energy

func XMen_United():
	var c = hand.teamCount(GameData.Teams.XMEN)
	res.addAttack(c * 2)
	return true

# Hawkeye

# Needs to have choice menu
func Covering_Fire():
	if hand.classCount(GameData.Classes.TECH) >= 1:
		var f1 = func():
			$"../PlayerHand".drawCard()
			emit_signal("finishCustom")
			
		var f2 = func():
			$"../BlackScreen".disappear()
			$"../BlackScreen".deleteCustomButtons()
			await $"../BlackScreen".chooseCardDiscard(1, 1)
			emit_signal("finishCustom")
			
		$"../BlackScreen".customChoices(["Draw", "Discard"], [f1, f2])

func Impossible_Trickshot():
	if "Impossible Trickshot" in $"../PlayerHand".eventCards:
		$"../PlayerHand".eventCards["Impossible Trickshot"] += 1
	else:
		$"../PlayerHand".eventCards["Impossible Trickshot"] = 1

func Quick_Draw():
	await hand.drawCard()
	return true

func Team_Player():
	if hand.teamCount(GameData.Teams.AVENGERS):
		res.addAttack(1)
	return true


# General funcs

func effect(card, args=[]):
	var s = card.getFuncName()
	if args.size() > 0:
		return await links[s].call(args)
	else:
		return await links[s].call()

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

func nullFunc():
	return true
	


var villain_prereqs = {
	"Spider Foes-Venom" : Venom_prereq
}

var villain_ambush = {
	"Spider Foes-Green Goblin" : GreenGoblin_ambush
}

var villain_fight = {
	"Henchmen-Sentinel" : Sentinel_Fight,
	"HYDRA-Endless Armies of Hydra" : Endless_Armies_Hydra_fight,
	"HYDRA-Viper" : Viper_fight_esc,
	"HYDRA-Hydra Kidnappers" : Kidnapper_fight,
	"Spider Foes-Doctor Octopus" : DocOc_fight,
	"Spider Foes-The Lizard" : Lizard_fight
}

var villain_escape = {
	"HYDRA-Viper" : Viper_fight_esc,
	"Spider Foes-Venom" : Venom_esc
}

func Sentinel_Fight():
	$"../BlackScreen".chooseCardKO(1, 1, ["hand", "played"], heroFilter)

func Endless_Armies_Hydra_fight():
	print("Endless Armies Fight")
	await $"../City".drawVilCard()
	await $"../City".drawVilCard()

func Viper_fight_esc():
	print("Running fight")
	for i in $"../PlayerHand".vicPile:
		if i.identifier == "Villain" and i.team == "HYDRA":
			print("Found HYDRA")
			return true
	await $"../PlayerHand".addWound(1)
	return true

func Kidnapper_fight():
	var f1 = func():
		print("f1")
		$"../HQ".addOfficer()
		emit_signal("finishCustom")
		
	var f2 = func():
		emit_signal("finishCustom")
		
	$"../BlackScreen".customChoices(["Add Officer", "Nothing"], [f1, f2])

func DocOc_fight():
	$"../PlayerHand".handSize += 2

func GreenGoblin_ambush():
	var v = $"../City".addedVil
	var b = $"../Bystanders".draw()
	if b:
		print("Adding bystander")
		v.bystanders += 1
		v.bList.append(b)
	else:
		print("Could not draw bystander")

func Lizard_fight():
	var ind = $"../City".focused
	if ind == 0:
		$"../PlayerHand".addWound(1)

func Venom_prereq():
	return $"../PlayerHand".classCount(GameData.Classes.COVERT, false, true) > 0

func Venom_esc():
	$"../PlayerHand".addWound(1)

var mastermind_strikes = {
	"Mastermind-Red Skull" : Red_Skull_Strike
}

func Red_Skull_Strike():
	$"../BlackScreen".chooseCardKO(1, 1, ["hand"], heroFilter)

var mastermind_prereqs = {
	
}

var tactic_fight = {
	"Red Skull-Endless Resources" : Endless_Resources,
	"Red Skull-Hydra Conspiracy" : Hydra_Conspiracy,
	"Red Skull-Negablast Grenades" : Negablast_Grenades,
	"Red Skull-Ruthless Dictator" : Ruthless_Dictator
}

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
	await $"../BlackScreen".KOFromDeck(1, 1, 3)
	await $"../BlackScreen".discardFromDeck(1, 1, 2)




var SchemeTwistLinks = {
	"Unleash the Power of the Cosmic Cube" : PowerCosmicCube_twist
}


# Schemes have pther setup funcs and twist funcs

func PowerCosmicCube_twist(t : int):
	#print("Twist cound ", t)
	if t == 5 or t == 6:
		$"../PlayerHand".deck.discard.append($"../Wounds".draw())
		$"../PlayerHand".deck.updateDiscardCount()
	elif t == 7:
		$"../PlayerHand".deck.discard.append($"../Wounds".draw())
		$"../PlayerHand".deck.discard.append($"../Wounds".draw())
		$"../PlayerHand".deck.discard.append($"../Wounds".draw())
		$"../PlayerHand".deck.updateDiscardCount()
	elif t == 8:
		$"..".lose()
