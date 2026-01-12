extends Node2D

enum Timing {
	END_OF_TURN
}

var modifiers = {}
var city_positions = [[], [], [], [], []]

func _ready() -> void:
	for i in Timing.values():
		modifiers[i] = []

func createModifier(info, target):
	var m = Modifier.new()
	m.createMod(info)
	modifiers[info.timing].append(m)
	m.apply(target)

func removeModifiers(t: Timing):
	var l = modifiers[t]
	for i in l:
		for j in city_positions:
			if i in j:
				j.erase(i)
		if i.target:
			i.remove()
	modifiers[t].clear()

func citySpotModifier(info, ind):
	var m = Modifier.new()
	m.createMod(info)
	modifiers[info.timing].append(m)
	city_positions[ind].append(m)
	if $"../City".city[ind]:
		m.apply($"../City".city[ind])

func applyCityPosition(ind):
	for i in city_positions[ind]:
		i.apply($"../City".city[ind])

func removeCityPosition(ind):
	if city_positions[ind]:
		for i in city_positions[ind]:
			i.remove()

func TidalWaveMM_On(c):
	c.attack -= 2

func TidalWaveMM_Off(c):
	c.attack += 2

var TidalWaveMasterMind = {
	mName = "TidalWaveMM",
	onEffect = TidalWaveMM_On,
	offEffect = TidalWaveMM_Off,
	timing = Timing.END_OF_TURN,
	text = "Tidal Wave: -2 attack this turn",
	mmover=false
}

func TidalWaveBridge_On(c):
	c.attack -= 2

func TidalWaveBridge_Off(c):
	c.attack += 2

var TidalWaveBridge = {
	mName = "TidalWaveBridge",
	onEffect = TidalWaveBridge_On,
	offEffect = TidalWaveBridge_Off,
	timing = Timing.END_OF_TURN,
	text = "Tidal Wave: -2 attack this turn",
	mmover=false
}

var LightningBolt = {
	mName = "LightningBolt",
	onEffect = TidalWaveBridge_On,
	offEffect = TidalWaveBridge_Off,
	timing = Timing.END_OF_TURN,
	text = "Lightning Bolt: -2 attack this turn",
	mmover=false
}
