class_name GameData


enum Heros {
	IRON_MAN,
	SPIDER_MAN,
	WOLVERINE,
	CYCLOPS,
	HAWKEYE,
	EMMA_FROST,
	NICK_FURY,
	HULK,
	CAPTAIN_AMERICA,
	BLACK_WIDOW,
	STORM,
	THOR
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

static var SHADOWED_THOUGHTS = {
	attack = 2,
	recruit = null,
	cost = 4,
	team = Teams.XMEN,
	hClass = Classes.COVERT,
	heroName = "Emma Frost",
	cardName = "Shadowed Thoughts",
	spritePath = "res://cards/Base/Heros/Emma Frost/EmmaFrost-ShadowedThoughts.png"
}

static var MENTAL_DISCIPLINE = {
	attack = null,
	recruit = 1,
	cost = 3,
	team = Teams.XMEN,
	hClass = Classes.RANGED,
	heroName = "Emma Frost",
	cardName = "Mental Discipline",
	spritePath = "res://cards/Base/Heros/Emma Frost/EmmaFrost-MentalDiscipline.png"
}

static var PSYCHIC_LINK = {
	attack = 3,
	recruit = null,
	cost = 5,
	team = Teams.XMEN,
	hClass = Classes.INSTINCT,
	heroName = "Emma Frost",
	cardName = "Psychic Link",
	spritePath = "res://cards/Base/Heros/Emma Frost/EmmaFrost-PsychicLink.png"
}

static var DIAMOND_FORM = {
	attack = 5,
	recruit = null,
	cost = 7,
	team = Teams.XMEN,
	hClass = Classes.STRENGTH,
	heroName = "Emma Frost",
	cardName = "Diamond Form",
	spritePath = "res://cards/Base/Heros/Emma Frost/EmmaFrost-DiamondForm.png"
}

static var BATTLEFIELD_PROMOTION = {
	attack = null,
	recruit = null,
	cost = 4,
	team = Teams.SHIELD,
	hClass = Classes.COVERT,
	heroName = "Nick Fury",
	cardName = "Battlefield Promotion",
	spritePath = "res://cards/Base/Heros/Nick Fury/NickFury-BattlefieldPromotion.png"
}

static var HIGHTECH_WEAPONRY = {
	attack = 2,
	recruit = null,
	cost = 3,
	team = Teams.SHIELD,
	hClass = Classes.TECH,
	heroName = "Nick Fury",
	cardName = "High-Tech Weaponry",
	spritePath = "res://cards/Base/Heros/Nick Fury/NickFury-HighTechWeaponry.png"
}

static var LEGENDARY_COMMANDER = {
	attack = 1,
	recruit = null,
	cost = 6,
	team = Teams.SHIELD,
	hClass = Classes.STRENGTH,
	heroName = "Nick Fury",
	cardName = "Legendary Commander",
	spritePath = "res://cards/Base/Heros/Nick Fury/NickFury-LegendaryCommander.png"
}

static var PURE_FURY = {
	attack = null,
	recruit = null,
	cost = 8,
	team = Teams.SHIELD,
	hClass = Classes.TECH,
	heroName = "Nick Fury",
	cardName = "Pure Fury",
	spritePath = "res://cards/Base/Heros/Nick Fury/NickFury-PureFury.png"
}

static var UNSTOPPABLE_HULK = {
	attack = 2,
	recruit = null,
	cost = 4,
	team = Teams.AVENGERS,
	hClass = Classes.INSTINCT,
	heroName = "Hulk",
	cardName = "Unstoppable Hulk",
	spritePath = "res://cards/Base/Heros/Hulk/Hulk-UnstoppableHulk.png"
}

static var GROWING_ANGER = {
	attack = 2,
	recruit = null,
	cost = 3,
	team = Teams.AVENGERS,
	hClass = Classes.STRENGTH,
	heroName = "Hulk",
	cardName = "Growing Anger",
	spritePath = "res://cards/Base/Heros/Hulk/Hulk-GrowingAnger.png"
}

static var CRAZED_RAMPAGE = {
	attack = 4,
	recruit = null,
	cost = 5,
	team = Teams.AVENGERS,
	hClass = Classes.STRENGTH,
	heroName = "Hulk",
	cardName = "Crazed Rampage",
	spritePath = "res://cards/Base/Heros/Hulk/Hulk-CrazedRampage.png"
}

static var HULK_SMASH = {
	attack = 5,
	recruit = null,
	cost = 8,
	team = Teams.AVENGERS,
	hClass = Classes.STRENGTH,
	heroName = "Hulk",
	cardName = "Hulk Smash!",
	spritePath = "res://cards/Base/Heros/Hulk/Hulk-HulkSmash.png"
}

static var AVENGERS_ASSEMBLE = {
	attack = null,
	recruit = 0,
	cost = 3,
	team = Teams.AVENGERS,
	hClass = Classes.INSTINCT,
	heroName = "Captain America",
	cardName = "Avengers Assemble!",
	spritePath = "res://cards/Base/Heros/Captain America/CaptainAmerica-AvengersAssemble.png"
}

static var PERFECT_TEAMWORK = {
	attack = 0,
	recruit = null,
	cost = 4,
	team = Teams.AVENGERS,
	hClass = Classes.STRENGTH,
	heroName = "Captain America",
	cardName = "Perfect Teamwork",
	spritePath = "res://cards/Base/Heros/Captain America/CaptainAmerica-PerfectTeamwork.png"
}

static var DIVING_BLOCK = {
	attack = 4,
	recruit = null,
	cost = 6,
	team = Teams.AVENGERS,
	hClass = Classes.TECH,
	heroName = "Captain America",
	cardName = "Diving Block",
	spritePath = "res://cards/Base/Heros/Captain America/CaptainAmerica-DivingBlock.png"
}

static var A_DAY_UNLIKE_ANY_OTHER = {
	attack = 3,
	recruit = null,
	cost = 7,
	team = Teams.AVENGERS,
	hClass = Classes.COVERT,
	heroName = "Captain America",
	cardName = "A Day Unlike Any Other",
	spritePath = "res://cards/Base/Heros/Captain America/CaptainAmerica-ADayUnlikeAnyOther.png"
}

static var DANGEROUS_RESCUE = {
	attack = 2,
	recruit = null,
	cost = 3,
	team = Teams.AVENGERS,
	hClass = Classes.COVERT,
	heroName = "Black Widow",
	cardName = "Dangerous Rescue",
	spritePath = "res://cards/Base/Heros/Black Widow/BlackWidow-DangerousRescue.png"
}

static var MISSION_ACCOMPLISHED = {
	attack = null,
	recruit = null,
	cost = 2,
	team = Teams.AVENGERS,
	hClass = Classes.TECH,
	heroName = "Black Widow",
	cardName = "Mission Accomplished",
	spritePath = "res://cards/Base/Heros/Black Widow/BlackWidow-MissionAccomplished.png"
}

static var COVERT_OPERATION = {
	attack = 0,
	recruit = null,
	cost = 4,
	team = Teams.AVENGERS,
	hClass = Classes.COVERT,
	heroName = "Black Widow",
	cardName = "Covert Operation",
	spritePath = "res://cards/Base/Heros/Black Widow/BlackWidow-CovertOperation.png"
}

static var SILENT_SNIPER = {
	attack = 4,
	recruit = null,
	cost = 7,
	team = Teams.AVENGERS,
	hClass = Classes.COVERT,
	heroName = "Black Widow",
	cardName = "Silent Sniper",
	spritePath = "res://cards/Base/Heros/Black Widow/BlackWidow-SilentSniper.png"
}

static var LIGHTNING_BOLT = {
	attack = 2,
	recruit = null,
	cost = 4,
	team = Teams.XMEN,
	hClass = Classes.RANGED,
	heroName = "Storm",
	cardName = "Lightning Bolt",
	spritePath = "res://cards/Base/Heros/Storm/Storm-LightningBolt.png"
}

static var GATHERING_STORM_CLOUDS = {
	attack = null,
	recruit = 2,
	cost = 3,
	team = Teams.XMEN,
	hClass = Classes.RANGED,
	heroName = "Storm",
	cardName = "Gathering Storm Clouds",
	spritePath = "res://cards/Base/Heros/Storm/Storm-GatheringStormClouds.png"
}

static var SPINNING_CYLCONE = {
	attack = 4,
	recruit = null,
	cost = 6,
	team = Teams.XMEN,
	hClass = Classes.COVERT,
	heroName = "Storm",
	cardName = "Spinning Cyclone",
	spritePath = "res://cards/Base/Heros/Storm/Storm-SpinningCyclone.png"
}

static var SURGE_OF_POWER = {
	attack = 0,
	recruit = 2,
	cost = 4,
	team = Teams.AVENGERS,
	hClass = Classes.RANGED,
	heroName = "Thor",
	cardName = "Surge of Power",
	spritePath = "res://cards/Base/Heros/Thor/Thor-SurgeOfPower.png"
}

static var ODINSON = {
	attack = null,
	recruit = 2,
	cost = 3,
	team = Teams.AVENGERS,
	hClass = Classes.STRENGTH,
	heroName = "Thor",
	cardName = "Odinson",
	spritePath = "res://cards/Base/Heros/Thor/Thor-Odinson.png"
}

static var CALL_LIGHTNING = {
	attack = 3,
	recruit = null,
	cost = 6,
	team = Teams.AVENGERS,
	hClass = Classes.RANGED,
	heroName = "Thor",
	cardName = "Call Lightning",
	spritePath = "res://cards/Base/Heros/Thor/Thor-CallLightning.png"
}

static var GOD_OF_THUNDER = {
	attack = 0,
	recruit = 5,
	cost = 8,
	team = Teams.AVENGERS,
	hClass = Classes.RANGED,
	heroName = "Thor",
	cardName = "God of Thunder",
	spritePath = "res://cards/Base/Heros/Thor/Thor-GodOfThunder.png"
}

static var TIDAL_WAVE = {
	attack = 5,
	recruit = null,
	cost = 7,
	team = Teams.XMEN,
	hClass = Classes.RANGED,
	heroName = "Storm",
	cardName = "Tidal Wave",
	spritePath = "res://cards/Base/Heros/Storm/Storm-TidalWave.png"
}

# Cards are in the order of common(5), common(5), uncommon(3), rare(1)
static var BASE_HEROS = {
	Heros.IRON_MAN : [REPULSOR_RAYS, ENDLESS_INVENTION, ARC_REACTOR, QUANTUM_BREAKTHROUGH],
	Heros.SPIDER_MAN : [ASTONISHING_STRENGTH, GREAT_RESPONSIBILITY, WEB_SHOOTERS, THE_AMAZING_SPIDERMAN],
	Heros.WOLVERINE : [HEALING_FACTOR, KEEN_SENSES, FRENZIED_SLASHING, BERSERKER_RAGE],
	Heros.CYCLOPS : [OPTIC_BLAST, DETERMINATION, UNENDING_ENERGY, XMEN_UNITED],
	Heros.HAWKEYE : [TEAM_PLAYER, QUICK_DRAW, COVERING_FIRE, IMPOSSIBLE_TRICKSHOT],
	Heros.EMMA_FROST : [SHADOWED_THOUGHTS, MENTAL_DISCIPLINE, PSYCHIC_LINK, DIAMOND_FORM],
	Heros.NICK_FURY : [BATTLEFIELD_PROMOTION, HIGHTECH_WEAPONRY, LEGENDARY_COMMANDER, PURE_FURY],
	Heros.HULK : [UNSTOPPABLE_HULK, GROWING_ANGER, CRAZED_RAMPAGE, HULK_SMASH],
	Heros.CAPTAIN_AMERICA : [AVENGERS_ASSEMBLE, PERFECT_TEAMWORK, DIVING_BLOCK, A_DAY_UNLIKE_ANY_OTHER],
	Heros.BLACK_WIDOW : [DANGEROUS_RESCUE, MISSION_ACCOMPLISHED, COVERT_OPERATION, SILENT_SNIPER],
	Heros.STORM : [LIGHTNING_BOLT, GATHERING_STORM_CLOUDS, SPINNING_CYLCONE, TIDAL_WAVE],
	Heros.THOR : [SURGE_OF_POWER, ODINSON, CALL_LIGHTNING, GOD_OF_THUNDER]
}













static var ABOMINATION = {
	name = "Abomination",
	attack = 5,
	team = "Radiation",
	vp = 3,
	spritePath = "res://cards/Base/Villains/Radiation-Abomination.png"
}

static var THE_LEADER = {
	name = "The Leader",
	attack = 4,
	team = "Radiation",
	vp = 2,
	spritePath = "res://cards/Base/Villains/Radiation-TheLeader.png"
}

static var MAESTRO = {
	name = "Maestro",
	attack = 6,
	team = "Radiation",
	vp = 4,
	spritePath = "res://cards/Base/Villains/Radiation-Maestro.png"
}

static var ZZZAX = {
	name = "Zzzax",
	attack = 5,
	team = "Radiation",
	vp = 3,
	spritePath = "res://cards/Base/Villains/Radiation-Zzzax.png"
}

static var RADIATION_VILLAINS = {
	ABOMINATION : 2,
	THE_LEADER : 2,
	MAESTRO : 2,
	ZZZAX : 2
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
	name = "Supreme Hydra",
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

static var BLOB = {
	name = "Blob",
	attack = 4,
	team = "Brotherhood",
	vp = 2,
	spritePath = "res://cards/Base/Villains/Brotherhood-Blob.png"
}

static var JUGGERNAUT = {
	name = "Juggernaut",
	attack = 6,
	team = "Brotherhood",
	vp = 4,
	spritePath = "res://cards/Base/Villains/Brotherhood-Juggernaut.png"
}

static var MYSTIQUE = {
	name = "Mystique",
	attack = 5,
	team = "Brotherhood",
	vp = 3,
	spritePath = "res://cards/Base/Villains/Brotherhood-Mystique.png"
}

static var SABRETOOTH = {
	name = "Sabretooth",
	attack = 5,
	team = "Brotherhood",
	vp = 3,
	spritePath = "res://cards/Base/Villains/Brotherhood-Sabretooth.png"
}

static var BROTHERHOOD_VILLAINS = {
	BLOB : 2,
	JUGGERNAUT : 2,
	MYSTIQUE : 2,
	SABRETOOTH : 2
}

static var BASE_VILLAINS = [
	SPIDERFOES_VILLAINS,
	HYDRA_VILLAINS,
	RADIATION_VILLAINS,
	BROTHERHOOD_VILLAINS
]





static var HENCHMAN_SENTINEL = {
	name = "Sentinel",
	attack = 3,
	team = "Henchmen",
	vp = 1,
	spritePath = "res://cards/Base/Villains/Henchman-Sentinel.png"
}

static var HENCHMAN_HANDNINJA = {
	name = "Hand Ninja",
	attack = 3,
	team = "Henchmen",
	vp = 1,
	spritePath = "res://cards/Base/Villains/Henchman-HandNinja.png"
}

static var HENCHMAN_DOOMBOTLEGION = {
	name = "Doombot Legion",
	attack = 3,
	team = "Henchmen",
	vp = 1,
	spritePath = "res://cards/Base/Villains/Henchman-DoombotLegion.png"
}

static var HENCHMAN_SAVAGELANDMUTATES = {
	name = "Savage Land Mutates",
	attack = 3,
	team = "Henchmen",
	vp = 1,
	spritePath = "res://cards/Base/Villains/Henchman-SavageLandMutates.png"
}

static var BASE_HENCHMEN = [
	HENCHMAN_SENTINEL,
	HENCHMAN_HANDNINJA,
	HENCHMAN_DOOMBOTLEGION,
	HENCHMAN_SAVAGELANDMUTATES
]









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

static var DR_DOOM = {
	mName = "Dr. Doom",
	leads = HENCHMAN_DOOMBOTLEGION,
	attack = 9,
	vp = 5,
	spritePath = "res://cards/Base/Masterminds/Mastermind-DrDoom.png",
	tactics = {
		"Treasures of Latveria" : "res://cards/Base/Masterminds/DrDoom-TreasuresOfLatveria.png",
		"Dark Technology" : "res://cards/Base/Masterminds/DrDoom-DarkTechnology.png",
		"Secrets of Time Travel" : "res://cards/Base/Masterminds/DrDoom-SecretsOfTimeTravel.png",
		"Monarch's Decree" : "res://cards/Base/Masterminds/DrDoom-MonarchsDecree.png"
	}
}

static var MAGNETO = {
	mName = "Magneto",
	leads = BROTHERHOOD_VILLAINS,
	attack = 8,
	vp = 5,
	spritePath = "res://cards/Base/Masterminds/Mastermind-Magneto.png",
	tactics = {
		"Bitter Captor" : "res://cards/Base/Masterminds/Magneto-BitterCaptor.png",
		"Crushing Shockwave" : "res://cards/Base/Masterminds/Magneto-CrushingShockwave.png",
		"Electromagnetic Bubble" : "res://cards/Base/Masterminds/Magneto-ElectromagneticBubble.png",
		"Xavier's Nemesis" : "res://cards/Base/Masterminds/Magneto-XaviersNemesis.png"
	}
}



static var BASE_MASTERMINDS = [
	RED_SKULL,
	DR_DOOM,
	MAGNETO
]










static var PowerCosmicCube = {
	sName = "Unleash the Power of the Cosmic Cube",
	twistCount = 8,
	overrides = {},
	spritePath = "res://cards/Base/Schemes/PowerCosmicCube.png",
	solo=true
}

static var LegacyVirus = {
	sName = "The Legacy Virus",
	twistCount = 8,
	overrides = {},
	spritePath = "res://cards/Base/Schemes/LegacyVirus.png",
	solo=true
}

static var NegativeZoneBreakout = {
	sName = "Negative Zone Prison Breakout",
	twistCount = 8,
	overrides = {},
	spritePath = "res://cards/Base/Schemes/NegativeZoneBreakout.png",
	solo=false
}

static var SuperHeroCivilWar = {
	sName = "Super Hero Civil War",
	twistCount = 8,
	overrides = {},
	spritePath = "res://cards/Base/Schemes/SuperHeroCivilWar.png",
	solo=false
}

static var PortalsDarkDimension = {
	sName = "Portals to the Dark Dimension",
	twistCount = 7,
	overrides = {},
	spritePath = "res://cards/Base/Schemes/PortalsDarkDimension.png",
	solo=true
}

static var MidtownBankRobbery = {
	sName = "Midtown Bank Robbery",
	twistCount = 8,
	overrides = {"Bystanders":12},
	spritePath = "res://cards/Base/Schemes/MidtownBankRobbery.png",
	solo=true
}

static var BASE_SCHEMES = [
	#PowerCosmicCube,
	#LegacyVirus,
	#NegativeZoneBreakout,
	#SuperHeroCivilWar,
	#PortalsDarkDimension,
	MidtownBankRobbery
]
