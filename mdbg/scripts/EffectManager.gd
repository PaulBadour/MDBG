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
	"Spiderman-Astonishing Strength" : Astonishing_Strength,
	"Spiderman-Great Responsibility" : Great_Responsibility,
	"Wolverine-Berserker Rage" : Berserker_Rage, # Some issue with drawing too many cards
	"Wolverine-Frenzied Slashing" : Frenzied_Slashing, # Some issue with drawing too many cards
	"Wolverine-Keen Senses" : Keen_Senses,
	"Cyclops-XMen United" : XMen_United,
	"Hawkeye-Quick Draw" : Quick_Draw,
	"Hawkeye-Team Player" : Team_Player
}

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

func Astonishing_Strength():
	var c = await hand.deck.reveal()
	if not c:
		return
	if c.cost <= 2:
		hand.drawCard()

func Great_Responsibility():
	var c = await hand.deck.reveal()
	if not c:
		return
	if c.cost <= 2:
		hand.drawCard()

# Requires saving bystanders
func Web_Shooters():
	pass

# Requires reveal multiple and choose order
func The_Amazing_Spiderman():
	pass
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

# Needs KOing wounds
func Healing_Factor():
	pass

func Keen_Senses():
	if hand.classCount(GameData.Classes.INSTINCT):
		hand.drawCard()

# Cyclops

# Both of these need discard
func Determination():
	pass

func Optic_Blast():
	pass

# This can actually just be null function, needs some functionality in the discard code
func Unending_Energy():
	pass

func XMen_United():
	var c = hand.teamCount(GameData.Teams.XMEN)
	res.addAttack(c * 2)

# Hawkeye

# Needs to have choice menu
func Covering_Fire():
	pass

# Needs city implementation
func Impossible_Trickshot():
	pass

func Quick_Draw():
	hand.drawCard()

func Team_Player():
	if hand.teamCount(GameData.Teams.AVENGERS):
		res.addAttack(1)


# General funcs

func effect(card, args=[]):
	var s = card.getFuncName()
	if args.size() > 0:
		links[s].call(args)
	else:
		links[s].call()


func nullFunc():
	return
