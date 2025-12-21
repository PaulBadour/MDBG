class_name HeroData

static func nullFunc():
	return

static var SHIELD_AGENT = {
	attack = null,
	recruit = 1,
	cost = 0,
	team = "SHIELD",
	hClass = "Classless",
	effect = nullFunc,
	heroName = "Hero",
	cardName = "SHIELD Agent",
	spritePath = "res://cards/Base/Heros/Hero/shield-agent.png"
}

static var SHIELD_TROOPER = {
	attack = 1,
	recruit = null,
	cost = 0,
	team = "SHIELD",
	hClass = "Classless",
	effect = nullFunc,
	heroName = "Hero",
	cardName = "SHIELD Trooper",
	spritePath = "res://cards/Base/Heros/Hero/shield-trooper.png"
}
