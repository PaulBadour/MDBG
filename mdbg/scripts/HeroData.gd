class_name HeroData

enum Heros {
	IRON_MAN,
	SPIDER_MAN,
	WOLVERINE,
	CYCLOPS,
	HAWKEYE
}

# Cards are in the order of common(5), common(5), uncommon(3), rare(1)
static var HERO_CARDS = {
	Heros.IRON_MAN : [REPULSOR_RAYS, ENDLESS_INVENTION, ARC_REACTOR, QUANTUM_BREAKTHROUGH],
	Heros.SPIDER_MAN : [ASTONISHING_STRENGTH, GREAT_RESPONSIBILITY, WEB_SHOOTERS, THE_AMAZING_SPIDERMAN],
	Heros.WOLVERINE : [HEALING_FACTOR, KEEN_SENSES, FRENZIED_SLASHING, BERSERKER_RAGE],
	Heros.CYCLOPS : [],
	Heros.HAWKEYE : []
}

enum Classes{
	STRENGTH,
	INSTINCT,
	COVERT,
	TECH,
	RANGED,
	BASIC
}

enum Teams{
	XMEN,
	AVENGERS,
	SHIELD,
	SPIDER_FRIENDS
}

static func nullFunc():
	return

static var SHIELD_AGENT = {
	attack = null,
	recruit = 1,
	cost = 0,
	team = Teams.SHIELD,
	hClass = Classes.BASIC,
	effect = nullFunc,
	heroName = "Hero",
	cardName = "SHIELD Agent",
	spritePath = "res://cards/Base/Heros/Hero/shield-agent.png"
}

static var SHIELD_TROOPER = {
	attack = 1,
	recruit = null,
	cost = 0,
	team = Teams.SHIELD,
	hClass = Classes.BASIC,
	effect = nullFunc,
	heroName = "Hero",
	cardName = "SHIELD Trooper",
	spritePath = "res://cards/Base/Heros/Hero/shield-trooper.png"
}

static var REPULSOR_RAYS = {
	attack = 2,
	recruit = null,
	cost = 3,
	team = Teams.AVENGERS,
	hClass = Classes.RANGED,
	effect = nullFunc,
	heroName = "Iron Man",
	cardName = "Repulsor Rays",
	spritePath = "res://cards/Base/Heros/Ironman/IronMan-RepulsorRays.png"
}

static var ENDLESS_INVENTION = {
	attack = null,
	recruit = null,
	cost = 3,
	team = Teams.AVENGERS,
	hClass = Classes.TECH,
	effect = nullFunc,
	heroName = "Iron Man",
	cardName = "Endless Invention",
	spritePath = "res://cards/Base/Heros/Ironman/IronMan-EndlessInvention.png"
}

static var ARC_REACTOR = {
	attack = 3,
	recruit = null,
	cost = 5,
	team = Teams.AVENGERS,
	hClass = Classes.TECH,
	effect = nullFunc,
	heroName = "Iron Man",
	cardName = "Arc Reactor",
	spritePath = "res://cards/Base/Heros/Ironman/IronMan-ArcReactor.png"
}

static var QUANTUM_BREAKTHROUGH = {
	attack = null,
	recruit = null,
	cost = 7,
	team = Teams.AVENGERS,
	hClass = Classes.TECH,
	effect = nullFunc,
	heroName = "Iron Man",
	cardName = "Quantum Breakthrough",
	spritePath = "res://cards/Base/Heros/Ironman/IronMan-QuantumBreakthrough.png"
}

static var ASTONISHING_STRENGTH = {
	attack = null,
	recruit = 1,
	cost = 2,
	team = Teams.SPIDER_FRIENDS,
	hClass = Classes.STRENGTH,
	effect = nullFunc,
	heroName = "Spiderman",
	cardName = "Astonishing Strength",
	spritePath = "res://cards/Base/Heros/Spiderman/Spiderman-AstonishingStrength.png"
}

static var GREAT_RESPONSIBILITY = {
	attack = 1,
	recruit = null,
	cost = 2,
	team = Teams.SPIDER_FRIENDS,
	hClass = Classes.INSTINCT,
	effect = nullFunc,
	heroName = "Spiderman",
	cardName = "Great Responsibility",
	spritePath = "res://cards/Base/Heros/Spiderman/Spiderman-GreatResponsibility.png"
}

static var WEB_SHOOTERS = {
	attack = null,
	recruit = null,
	cost = 2,
	team = Teams.SPIDER_FRIENDS,
	hClass = Classes.TECH,
	effect = nullFunc,
	heroName = "Spiderman",
	cardName = "Web Shooters",
	spritePath = "res://cards/Base/Heros/Spiderman/Spiderman-WebShooters.png"
}

static var THE_AMAZING_SPIDERMAN = {
	attack = null,
	recruit = null,
	cost = 2,
	team = Teams.SPIDER_FRIENDS,
	hClass = Classes.COVERT,
	effect = nullFunc,
	heroName = "Spiderman",
	cardName = "The Amazing Spiderman",
	spritePath = "res://cards/Base/Heros/Spiderman/Spiderman-TheAmazingSpiderman.png"
}

static var HEALING_FACTOR = {
	attack = 2,
	recruit = null,
	cost = 3,
	team = Teams.XMEN,
	hClass = Classes.INSTINCT,
	effect = nullFunc,
	heroName = "Wolverine",
	cardName = "Healing Factor",
	spritePath = "res://cards/Base/Heros/Wolverine/Wolverine-HealingFactor.png"
}

static var KEEN_SENSES = {
	attack = 1,
	recruit = null,
	cost = 2,
	team = Teams.XMEN,
	hClass = Classes.INSTINCT,
	effect = nullFunc,
	heroName = "Wolverine",
	cardName = "Keen Senses",
	spritePath = "res://cards/Base/Heros/Wolverine/Wolverine-KeenSenses.png"
}

static var FRENZIED_SLASHING = {
	attack = 2,
	recruit = null,
	cost = 5,
	team = Teams.XMEN,
	hClass = Classes.INSTINCT,
	effect = nullFunc,
	heroName = "Wolverine",
	cardName = "Frenzied Slashing",
	spritePath = "res://cards/Base/Heros/Wolverine/Wolverine-FrenziedSlashing.png"
}

static var BERSERKER_RAGE = {
	attack = 0,
	recruit = null,
	cost = 8,
	team = Teams.XMEN,
	hClass = Classes.INSTINCT,
	effect = nullFunc,
	heroName = "Wolverine",
	cardName = "Berserker Rage",
	spritePath = "res://cards/Base/Heros/Wolverine/Wolverine-BerserkerRage.png"
}
