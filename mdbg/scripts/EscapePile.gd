extends "res://scripts/Pile.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func countVils():
	var c = 0
	for i in cards:
		if i.identifier == "Villain":
			c += 1
	return c

func countBystanders():
	var c = 0
	for i in cards:
		if i.identifier == "Bystander":
			c += 1
	return c

func countKillbots():
	var c = 0
	for i in cards:
		if i.identifier == "Villain" and i.cardName == "Killbot":
			c += 1
	return c

func countSkrullInvasion():
	var c = 0
	for i in cards:
		if i.identifier == "Hero" or (i.identifier == "Villain" and i.team == "SecretSkrulls"):
			c += 1
	return c

func addCards(c):
	super(c)
	if $"../Scheme".sName == "Negative Zone Prison Breakout" and countVils() >= 12:
		await $"..".lose()
	if $"../Scheme".sName == "Midtown Bank Robbery" and countBystanders() >= 8:
		await $"..".lose()
	if $"../Scheme".sName == "Replace Earth's Leaders with Killbots" and countKillbots() >= 5:
		await $"..".lose()
	if c.identifier == "Villain" and c.team == "Skrulls" and c.extraData:
		addCards(c.extraData)
	if $"../Scheme".sName == "Secret Invasion of the Skrull Shapeshifters" and countSkrullInvasion() >= 6:
		await $"..".lose()
