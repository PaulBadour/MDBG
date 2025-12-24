extends Node2D

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
	"Hawkeye-Team Player" : Team_Player
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

# Requires reveal multiple and choose order
func The_Amazing_Spiderman():
	var c = await hand.deck.reveal(3)
	var nc = 0
	for i in c:
		if i.cost <= 2:
			hand.deck.cards.erase(i)
			hand.addCardToHand(i)
			hand.deck.updateDrawCount()
			print("Drawing card")
		else:
			print("Not drawing")
			nc += 1
	if nc > 1:
		print("Ordering ", nc)
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
	pass

# Needs city implementation
func Impossible_Trickshot():
	pass

func Quick_Draw():
	hand.drawCard()
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

func nullFunc():
	return true
