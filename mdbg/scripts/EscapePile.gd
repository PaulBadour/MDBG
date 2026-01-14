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

func addCards(c):
	super(c)
	if $"../Scheme".sName == "Negative Zone Prison Breakout" and countVils() >= 12:
		$"..".lose()
	if $"../Scheme".sName == "Midtown Bank Robbery" and countBystanders() >= 8:
		$"..".lose()
