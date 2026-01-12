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

var addedVil

const MM_ZONE = [290, 510]

var focused = null

const OOS = Vector2(1217, -1224)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and !focused and $"..".yourTurn:
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

func _on_fight_button_down(autoKill=null) -> void:
	var currAttack = $"../Resources".attack
	var attack
	var skipChecks = false
	if autoKill != null:
		focused = autoKill
		skipChecks = true
	if focused == -1:
		attack = $"../Mastermind".attack
		if currAttack >= attack or skipChecks:
			
			if !skipChecks and $"../Mastermind".getFuncName() in $"../EffectManager".mastermind_prereqs.keys():
				if !$"../EffectManager".mastermind_prereqs[$"../Mastermind".getFuncName()].call():
					return
			if !skipChecks and attack > 0:
				$"../Resources".addAttack(-attack)
			var t = $"../Mastermind".drawTactic()
			$"../PlayerHand".vicPile.append(t)
			for i in $"../Mastermind".bystanders:
				$"../PlayerHand".vicPile.append(i)
			
			$"../Mastermind".clearBystanders()
			$"../PlayerHand".killOrRecruit = true

			var fName = str($"../Mastermind".mName, "-", t.tName)
			if fName in $"../EffectManager".tactic_fight.keys():
				$"../EffectManager".tactic_fight[fName].call()
			
			if $"../Mastermind".tactics.size() == 0:
				$"..".win()
			
	else:
		attack = city[focused].attack
		if skipChecks or currAttack >= attack:
			
			if !skipChecks and city[focused].getFuncName() in $"../EffectManager".villain_prereqs.keys():
				if !$"../EffectManager".villain_prereqs[city[focused].getFuncName()].call():
					return
			if $"..".PLAYER_COUNT > 1:
				$"../..".socket.send_text(str("Fought:", focused))
			var card = city[focused]
			city[focused] = null
			card.position = OOS
			if card.getFuncName() in $"../EffectManager".villain_fight.keys():
				await $"../EffectManager".villain_fight[card.getFuncName()].call()
			if !skipChecks and attack > 0:
				$"../Resources".addAttack(-attack)
			$"../PlayerHand".vicPile.append(card)
			for i in card.bystanders:
				$"../PlayerHand".vicPile.append(i)
			$"../PlayerHand".killOrRecruit = true

	if "Impossible Trickshot" in $"../PlayerHand".eventCards:
		for i in range($"../PlayerHand".eventCards["Impossible Trickshot"]):
			$"../PlayerHand".saveBystander()
			$"../PlayerHand".saveBystander()
			$"../PlayerHand".saveBystander()
	
	if "Diamond Form" in $"../PlayerHand".eventCards:
		for i in range($"../PlayerHand".eventCards["Diamond Form"]):
			$"../Resources".addRecruit(3)
	_on_cancel_button_down()


func _on_cancel_button_down() -> void:
	emit_signal("unFocusCity")
	$Fight.position = Vector2(-400, y - BUTTON_Y_OFFSET)
	$Cancel.position = Vector2(-400, y + BUTTON_Y_OFFSET)
	focused = null

func addToCity(c):
	var esc = true
	addedVil = c
	for i in range(5):
		#if i == 0 and c.getFuncName() in $"../EffectManager".villain_ambush.keys():
			#await $"../EffectManager".villain_ambush[c.getFuncName()].call()
		if city[i] == null:
			city[i] = c
			c.position = calcCardPosition(i)
			c.z_index = 3
			$"../ModifierManager".applyCityPosition(i)
			esc = false
			break
		$"../ModifierManager".removeCityPosition(i)
		var newC = city[i]
		city[i] = c
		$"../ModifierManager".applyCityPosition(i)
		c.position = calcCardPosition(i)
		if i == 0:
			c.z_index = 3
		c = newC
	
	if esc:
		$"../EscapePile".addCards(c)
		c.position = OOS
		if c.getFuncName() in $"../EffectManager".villain_escape.keys():
			await $"../EffectManager".villain_escape[c.getFuncName()].call()
		if $"..".yourTurn:
			await $"../BlackScreen".KOfromHQ($"../EffectManager".sixCostFilter)

		if c.bystanders.size() > 0:
			await $"../BlackScreen".chooseCardDiscard(1, 1, false)
	
	if addedVil.getFuncName() in $"../EffectManager".villain_ambush.keys():
		await $"../EffectManager".villain_ambush[addedVil.getFuncName()].call()


func addBystander(b):
	for i in city:
		if i:
			i.captureBystander(b)
			return
	$"../Mastermind".captureBystander(b)

func removeVil(ind):
	if $"../CardManager".cardZoomed == city[ind]:
		$"../CardManager".oldZoomPos = Vector2(-255, 1726)
	var card = city[ind]
	card.position = Vector2(-255, 1726)
	city[ind] = null
	if card.getFuncName() in $"../EffectManager".villain_aopfight.keys():
		focused = ind
		await $"../EffectManager".villain_aopfight[card.getFuncName()].call()
		focused = null
	
	

func reveal(c):
	var oldz = c.z_index
	var oldScale = c.scale
	c.position = Vector2(1000, 500)
	c.z_index = 10
	c.scale = Vector2(2, 2)
	await get_tree().create_timer(1.5).timeout
	c.position = Vector2(-500, 0)
	c.z_index = oldz
	c.scale = oldScale

func calcCardPosition(ind):
	return Vector2(START_X - (ind * DECR), y)

func drawVilCard():
	var vc = $"../VillainDeck".draw()
	if !vc:
		print("Game over")
		return
	await reveal(vc)
	if vc.identifier == "Villain":
		print("Vil")
		await addToCity(vc)
	elif vc.identifier == "Twist":
		print("Twist!")
		await $"../Scheme".twist()
	elif vc.identifier == "Master Strike":
		print("Strike")
		await $"../Mastermind".strike()
	elif vc.identifier == "Bystander":
		
		print("Bystander")
		addBystander(vc)
	else:
		print(vc.identifier)
