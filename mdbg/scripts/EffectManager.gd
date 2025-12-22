extends Node2D

@onready
var hand = $"../PlayerHand"
@onready
var res = $"../Resources"

var links = {
	"Hero-SHIELD Trooper" : nullFunc,
	"Hero-SHIELD Agent" : nullFunc,
	"Iron Man-Repulsor Rays" : Repulsor_Rays,
	"Iron Man-Quantum Breakthrough" : Quantum_Breakthrough,
	"Iron Man-Endless Invention" : Endless_Invention,
	"Iron Man-Arc Reactor" : Arc_Reactor,
	"Wolverine-Berserker Rage" : Berserker_Rage, # Some issue with drawing too many cards
	"Wolverine-Frenzied Slashing" : Frenzied_Slashing # Some issue with drawing too many cards
}

func nullFunc():
	return

# Iron Man
func Repulsor_Rays():
	if hand.classCount(GameData.Classes.RANGED) >= 1:
		res.addAttack(1)

func Quantum_Breakthrough():
	hand.drawCard()
	hand.drawCard()
	if hand.classCount(GameData.Classes.TECH):
		hand.drawCard()
		hand.drawCard()

func Endless_Invention():
	hand.drawCard()
	if hand.classCount(GameData.Classes.TECH):
		hand.drawCard()

func Arc_Reactor():
	var c = hand.classCount(GameData.Classes.TECH)
	if c:
		res.addAttack(c)

# SpiderMan

# Wolverine

func Berserker_Rage():
	hand.drawCard()
	hand.drawCard()
	hand.drawCard()
	if hand.classCount(GameData.Classes.INSTINCT):
		res.addAttack(hand.extraDraws)

func Frenzied_Slashing():
	if hand.classCount(GameData.Classes.INSTINCT):
		hand.drawCard()
		hand.drawCard()

# Cyclops

# Hawkeye

func effect(card, args=[]):
	var s = card.getFuncName()
	if args.size() > 0:
		links[s].call(args)
	else:
		links[s].call()
