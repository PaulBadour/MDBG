extends Node2D

signal focusedCity
signal unFocusCity

const y = 225
const START_X = 1475
const DECR = 200

const BUTTON_X_OFFSET = 50
const BUTTON_Y_OFFSET = 50

const CARD_SIZE_X = 160
const CARD_SIZE_Y = 225

const CHECK_Y_MIN = y - (CARD_SIZE_Y / 2.0)
const CHECK_Y_MAX = y + (CARD_SIZE_Y / 2.0)

var city = [null, null, null, null, null]
var cityZones = [null, null, null, null, null]

const MM_ZONE = [290, 510]

var focused = null

const OOS = Vector2(1217, -1224)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#escaped = null
	for i in range(5):
		cityZones[i] = [(START_X - (i*DECR)) - (CARD_SIZE_X/2.0), (START_X - (i*DECR)) + (CARD_SIZE_X/2.0)]

func focus(zone):
	if focused == null:
		emit_signal("focusedCity")
		focused = zone
		var xButton
		if focused == -1:
			xButton = 400 + BUTTON_X_OFFSET
		else:
			xButton = START_X - (zone * DECR) + BUTTON_X_OFFSET
		$Fight.position = Vector2(xButton, y - BUTTON_Y_OFFSET)
		$Cancel.position = Vector2(xButton, y + BUTTON_Y_OFFSET)

func _input(event: InputEvent) -> void:
	if $"../BlackScreen".isClickable:
		return
	if $"../HQ".focused:
		return
	if event is InputEventKey and event.keycode == KEY_V and event.is_pressed():
		drawVilCard()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and !focused:
		var pos = get_viewport().get_mouse_position()
		if pos.y < CHECK_Y_MIN or pos.y > CHECK_Y_MAX:
			return
		var zone = -1
		for i in range(5):
			if pos.x > cityZones[i][0] and pos.x < cityZones[i][1] and city[i]:
				zone = i
				break
		if zone >= 0:
			focus(zone) 
			
		elif pos.x > MM_ZONE[0] and pos.x < MM_ZONE[1]:
			focus(-1)

func _on_fight_button_down() -> void:
	var currAttack = $"../Resources".attack
	var attack
	if focused == -1:
		attack = $"../Mastermind".attack
		if currAttack >= attack:
			if $"../Mastermind".getFuncName() in $"../EffectManager".mastermind_prereqs.keys():
				if !$"../EffectManager".mastermind_prereqs[$"../Mastermind".getFuncName()].call():
					return
			
			$"../Resources".addAttack(-attack)
			var t = $"../Mastermind".drawTactic()
			$"../PlayerHand".vicPile.append(t)
			for i in $"../Mastermind".bystanders:
				$"../PlayerHand".vicPile.append(i)
			$"../Mastermind".bystanders.clear()
			$"../PlayerHand".killOrRecruit = true
			
			var fName = str($"../Mastermind".mName, "-", t.tName)
			if fName in $"../EffectManager".tactic_fight.keys():
				$"../EffectManager".tactic_fight[fName].call()
			
			if $"../Mastermind".tactics.size() == 0:
				$"..".win()
			
	else:
		attack = city[focused].attack
		if currAttack >= attack:
			
			if city[focused].getFuncName() in $"../EffectManager".villain_prereqs.keys():
				if !$"../EffectManager".villain_prereqs[city[focused].getFuncName()].call():
					return
			
			if city[focused].getFuncName() in $"../EffectManager".villain_fight.keys():
				$"../EffectManager".villain_fight[city[focused].getFuncName()].call()
			$"../Resources".addAttack(-attack)
			$"../PlayerHand".vicPile.append(city[focused])
			for i in city[focused].bList:
				$"../PlayerHand".vicPile.append(i)
			city[focused].position = OOS
			$"../PlayerHand".killOrRecruit = true
			
			city[focused] = null
	if "Impossible Trickshot" in $"../PlayerHand".eventCards:
		for i in range($"../PlayerHand".eventCards["Impossible Trickshot"]):
			$"../PlayerHand".saveBystander()
			$"../PlayerHand".saveBystander()
			$"../PlayerHand".saveBystander()
	_on_cancel_button_down()


func _on_cancel_button_down() -> void:
	emit_signal("unFocusCity")
	$Fight.position = Vector2(-400, y - BUTTON_Y_OFFSET)
	$Cancel.position = Vector2(-400, y + BUTTON_Y_OFFSET)
	focused = null

func addToCity(c):
	for i in range(5):
		if city[i] == null:
			city[i] = c
			c.position = Vector2(START_X - (i * DECR), y)
			c.z_index = 3
			if i == 0 and c.getFuncName() in $"../EffectManager".villain_ambush.keys():
				$"../EffectManager".villain_ambush[c.getFuncName()].call()
			return
		var newC = city[i]
		city[i] = c
		c.position = Vector2(START_X - (i * DECR), y)
		if i == 0:
			c.z_index = 3
		c = newC
	$"../EscapePile".addCards(c)
	c.position = OOS
	if c.getFuncName() in $"../EffectManager".villain_escape.keys():
		$"../EffectManager".villain_escape[c.getFuncName()].call()

	await $"../BlackScreen".KOfromHQ($"../EffectManager".sixCostFilter)
	if c.bystanders > 0:
		await $"../BlackScreen".chooseCardDiscard(1, 1, false)

func addBystander():
	for i in city:
		if i:
			i.bystanders += 1
			i.bList.append($"../Bystanders".draw())
			return
	$"../Mastermind".bystanders.append($"../Bystanders".draw())

func drawVilCard():
	var vc = $"../VillainDeck".draw()
	if !vc:
		print("Game over")
		return
	elif vc.identifier == "Villain":
		print("Vil")
		addToCity(vc)
	elif vc.identifier == "Twist":
		print("Twist!")
		$"../Scheme".twist()
	elif vc.identifier == "Master Strike":
		print("Strike")
		$"../Mastermind".strike()
	elif vc.identifier == "Bystander":
		print("Bystander")
		addBystander()
	else:
		print(vc.identifier)
