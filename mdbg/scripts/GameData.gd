
class_name GameData


enum Heros {
	IRON_MAN,
	SPIDER_MAN,
	WOLVERINE,
	CYCLOPS,
	HAWKEYE
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

static var SHIELD_AGENT = {
	attack = null,
	recruit = 1,
	cost = 0,
	team = Teams.SHIELD,
	hClass = Classes.BASIC,
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
	heroName = "Hero",
	cardName = "SHIELD Trooper",
	spritePath = "res://cards/Base/Heros/Hero/shield-trooper.png"
}

static var SHIELD_OFFICER = {
	attack = null,
	recruit = 2,
	cost = 3,
	team = Teams.SHIELD,
	hClass = Classes.BASIC,
	heroName = "Hero",
	cardName = "SHIELD Officer",
	spritePath = "res://cards/Base/Heros/Hero/shield-officer.png"
}

#func imrr():
	#if $PlayerHand.classCount():
		#pass

static var REPULSOR_RAYS = {
	attack = 2,
	recruit = null,
	cost = 3,
	team = Teams.AVENGERS,
	hClass = Classes.RANGED,
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
	heroName = "Wolverine",
	cardName = "Berserker Rage",
	spritePath = "res://cards/Base/Heros/Wolverine/Wolverine-BerserkerRage.png"
}

static var DETERMINATION = {
	attack = null,
	recruit = 3,
	cost = 2,
	team = Teams.XMEN,
	hClass = Classes.STRENGTH,
	heroName = "Cyclops",
	cardName = "Determination",
	spritePath = "res://cards/Base/Heros/Cyclops/Cyclops-Determination.png"
}

static var OPTIC_BLAST = {
	attack = 3,
	recruit = null,
	cost = 3,
	team = Teams.XMEN,
	hClass = Classes.RANGED,
	heroName = "Cyclops",
	cardName = "Optic Blast",
	spritePath = "res://cards/Base/Heros/Cyclops/Cyclops-OpticBlast.png"
}

static var UNENDING_ENERGY = {
	attack = 4,
	recruit = null,
	cost = 6,
	team = Teams.XMEN,
	hClass = Classes.RANGED,
	heroName = "Cyclops",
	cardName = "Unending Energy",
	spritePath = "res://cards/Base/Heros/Cyclops/Cyclops-UnendingEnergy.png"
}

static var XMEN_UNITED = {
	attack = 6,
	recruit = null,
	cost = 8,
	team = Teams.XMEN,
	hClass = Classes.RANGED,
	heroName = "Cyclops",
	cardName = "XMen United",
	spritePath = "res://cards/Base/Heros/Cyclops/Cyclops-XMenUnited.png"
}

static var QUICK_DRAW = {
	attack = 1,
	recruit = null,
	cost = 3,
	team = Teams.AVENGERS,
	hClass = Classes.INSTINCT,
	heroName = "Hawkeye",
	cardName = "Quick Draw",
	spritePath = "res://cards/Base/Heros/Hawkeye/Hawkeye-QuickDraw.png"
}

static var TEAM_PLAYER = {
	attack = 2,
	recruit = null,
	cost = 4,
	team = Teams.AVENGERS,
	hClass = Classes.TECH,
	heroName = "Hawkeye",
	cardName = "Team Player",
	spritePath = "res://cards/Base/Heros/Hawkeye/Hawkeye-TeamPlayer.png"
}

static var COVERING_FIRE = {
	attack = 3,
	recruit = null,
	cost = 5,
	team = Teams.AVENGERS,
	hClass = Classes.TECH,
	heroName = "Hawkeye",
	cardName = "Covering Fire",
	spritePath = "res://cards/Base/Heros/Hawkeye/Hawkeye-CoveringFire.png"
}

static var IMPOSSIBLE_TRICKSHOT = {
	attack = 5,
	recruit = null,
	cost = 7,
	team = Teams.AVENGERS,
	hClass = Classes.TECH,
	heroName = "Hawkeye",
	cardName = "Impossible Trick Shot",
	spritePath = "res://cards/Base/Heros/Hawkeye/Hawkeye-ImpossibleTrickShot.png"
}

# Cards are in the order of common(5), common(5), uncommon(3), rare(1)
static var BASE_HEROS = {
	Heros.IRON_MAN : [REPULSOR_RAYS, ENDLESS_INVENTION, ARC_REACTOR, QUANTUM_BREAKTHROUGH],
	Heros.SPIDER_MAN : [ASTONISHING_STRENGTH, GREAT_RESPONSIBILITY, WEB_SHOOTERS, THE_AMAZING_SPIDERMAN],
	Heros.WOLVERINE : [HEALING_FACTOR, KEEN_SENSES, FRENZIED_SLASHING, BERSERKER_RAGE],
	Heros.CYCLOPS : [OPTIC_BLAST, DETERMINATION, UNENDING_ENERGY, XMEN_UNITED],
	Heros.HAWKEYE : [TEAM_PLAYER, QUICK_DRAW, COVERING_FIRE, IMPOSSIBLE_TRICKSHOT]
}


static var RED_SKULL = {
	mName = "Red Skull",
	leads = HYDRA_VILLAINS,
	attack = 7,
	vp = 5,
	spritePath = "res://cards/Base/Masterminds/Mastermind-RedSkull.png",
	tactics = {
		"Endless Resources" : "res://cards/Base/Masterminds/RedSkull-EndlessResources.png",
		"Hydra Conspiracy" : "res://cards/Base/Masterminds/RedSkull-HydraConspiracy.png",
		"Negablast Grenades" : "res://cards/Base/Masterminds/RedSkull-NegablastGrenades.png",
		"Ruthless Dictator" : "res://cards/Base/Masterminds/RedSkull-RuthlessDictator.png"
	}
}

static var ENDLESS_ARMIES_HYDRA = {
	name = "Endless Armies of Hydra",
	attack = 4,
	team = "HYDRA",
	vp = 3,
	spritePath = "res://cards/Base/Villains/HYDRA-Endless Arms of Hydra.png"
}

static var HYDRA_KIDNAPPERS = {
	name = "Hydra Kidnappers",
	attack = 3,
	team = "HYDRA",
	vp = 1,
	spritePath = "res://cards/Base/Villains/HYDRA-Hydra Kidnappers.png"
}

static var SUPREME_HYDRA = {
	name = "Endless Armies of Hydra",
	attack = 6,
	team = "HYDRA",
	vp = 3,
	spritePath = "res://cards/Base/Villains/HYDRA-Supreme Hydra.png"
}

static var VIPER = {
	name = "Viper",
	attack = 5,
	team = "HYDRA",
	vp = 3,
	spritePath = "res://cards/Base/Villains/HYDRA-Viper.png"
}

static var HYDRA_VILLAINS = {
	ENDLESS_ARMIES_HYDRA : 3,
	HYDRA_KIDNAPPERS : 3,
	SUPREME_HYDRA : 1,
	VIPER : 1
}

static var DOCTOR_OCTOPUS = {
	name = "Doctor Octopus",
	attack = 4,
	team = "Spider Foes",
	vp = 2,
	spritePath = "res://cards/Base/Villains/SpiderFoes-DoctorOctopus.png"
}

static var GREEN_GOBLIN = {
	name = "Green Goblin",
	attack = 6,
	team = "Spider Foes",
	vp = 4,
	spritePath = "res://cards/Base/Villains/SpiderFoes-GreenGoblin.png"
}

static var THE_LIZARD = {
	name = "The Lizard",
	attack = 3,
	team = "Spider Foes",
	vp = 2,
	spritePath = "res://cards/Base/Villains/SpiderFoes-TheLizard.png"
}

static var VENOM = {
	name = "Venom",
	attack = 5,
	team = "Spider Foes",
	vp = 3,
	spritePath = "res://cards/Base/Villains/SpiderFoes-Venom.png"
}

static var SPIDERFOES_VILLAINS = {
	GREEN_GOBLIN : 2,
	DOCTOR_OCTOPUS : 2,
	THE_LIZARD : 2,
	VENOM : 2
}

static var HENCHMAN_SENTINEL = {
	name = "Sentinel",
	attack = 3,
	team = "Henchmen",
	vp = 1,
	spritePath = "res://cards/Base/Villains/Henchman-Sentinel.png"
}

static var BASE_HENCHMEN = [
	HENCHMAN_SENTINEL
]

static var PowerCosmicCube = {
	sName = "Unleash the Power of the Cosmic Cube",
	twistCount = 8,
	spritePath = "res://cards/Base/Schemes/PowerCosmicCube.png"
}
