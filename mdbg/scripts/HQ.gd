extends Node2D

signal focusedHQ
signal unFocusHQ



const y = 525
const START_X = 1475
const DECR = 200

const BUTTON_X_OFFSET = 50
const BUTTON_Y_OFFSET = 50

const CARD_SIZE_X = 160
const CARD_SIZE_Y = 225

const CHECK_Y_MIN = y - (CARD_SIZE_Y / 2.0)
const CHECK_Y_MAX = y + (CARD_SIZE_Y / 2.0)

var officerCount = 30
var displayOfficer
const OFFICER_ZONE = [290, 510]
const officerPos = Vector2(400, y)

var hq = [null, null, null, null, null]
var hqZones = [null, null, null, null, null]
# 1300 . 
# at 275

var focused = null

func _ready():
	var heroScene = preload("res://Scenes/Hero.tscn")
	displayOfficer = heroScene.instantiate()
	displayOfficer.initHero(GameData.SHIELD_OFFICER)
	$"../PlayerHand".addCardToManager(displayOfficer)
	displayOfficer.position = officerPos
	displayOfficer.z_index = 5

# Cancel button
func _on_cancel_button_down() -> void:
	emit_signal("unFocusHQ")
	$Recruit.position = Vector2(-400, y - BUTTON_Y_OFFSET)
	$Cancel.position = Vector2(-400, y + BUTTON_Y_OFFSET)
	focused = null

# Recruit button
func _on_recruit_button_down() -> void:
	var currRecruit = $"../Resources".recruit
	if focused >= 0:
		var cost = hq[focused].cost
		if currRecruit >= cost:
			if $"..".PLAYER_COUNT > 1:
				$"../..".socket.send_text(str("Recruited:", focused))
			$"../Resources".addRecruit(-cost)
			$"../PlayerHand".deck.discardCard(hq[focused])
			hq[focused] = null
			fillHQ()
	else:
		if currRecruit >= 3:
			if $"..".PLAYER_COUNT > 1:
				$"../..".socket.send_text(str("Recruited:-1"))
			$"../Resources".addRecruit(-3)
			addOfficer()
			
	$"../PlayerHand".killOrRecruit = true
	_on_cancel_button_down()

func addOfficer(fake = false):
	if officerCount == 1:
		if fake:
			if $"../CardManager".cardZoomed == displayOfficer:
				$"../CardManager".oldZoomPos = Vector2(1626, -310)
			displayOfficer.position = Vector2(1626, -310)
		else:
			$"../PlayerHand".deck.discardCard(displayOfficer)
	elif not fake:
		var newOfficer = preload("res://Scenes/Hero.tscn").instantiate()
		newOfficer.initHero(GameData.SHIELD_OFFICER)
		$"../PlayerHand".addCardToManager(newOfficer)
		newOfficer.position = Vector2(-906, 906)
		$"../PlayerHand".deck.discardCard(newOfficer)
	officerCount -= 1

func removeHero(ind):
	hq[ind].position = Vector2(-324, 1626)
	if $"../CardManager".cardZoomed == hq[ind]:
		$"../CardManager".oldZoomPos = Vector2(-324, 1626)
	hq[ind] = null
	fillHQ()

func focus(zone):
	if focused == null:
		emit_signal("focusedHQ")
		focused = zone
		var xButton
		if focused == -1:
			xButton = 400 + BUTTON_X_OFFSET
		else:
			xButton = START_X - (zone * DECR) + BUTTON_X_OFFSET
		$Recruit.position = Vector2(xButton, y - BUTTON_Y_OFFSET)
		$Cancel.position = Vector2(xButton, y + BUTTON_Y_OFFSET)

func _input(event: InputEvent) -> void:
	if $"../BlackScreen".isClickable:
		return
	if $"../City".focused:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and !focused and !$"../BlackScreen".isCovered and $"..".yourTurn:
		var pos = get_viewport().get_mouse_position()
		if pos.y < CHECK_Y_MIN or pos.y > CHECK_Y_MAX:
			return
		var zone = -1
		for i in range(5):
			if pos.x > hqZones[i][0] and pos.x < hqZones[i][1]:
				zone = i
				break
		
		if zone >= 0:
			focus(zone)

		elif pos.x > OFFICER_ZONE[0] and pos.x < OFFICER_ZONE[1] and officerCount > 0:
			focus(-1)

func calcHQZones():
	for i in range(5):
		hqZones[i] = [(START_X - (i*DECR)) - (CARD_SIZE_X/2.0), (START_X - (i*DECR)) + (CARD_SIZE_X/2.0)]

func fillHQ():
	for i in range(5):
		if !hq[i]:
			var card = $"../HeroDeck".draw()
			card.position = Vector2(START_X - (i * DECR), y)
			card.z_index = 3
			hq[i] = card

func KOhero(c, send=true):
	var ind = hq.find(c)
	$"../KODeck".addCards(hq[ind])
	hq[ind].position = Vector2(200, -420)
	hq[ind] = null
	if $"../..".playerCount > 1 and send:
		$"../..".socket.send_text(str("Recruited:", ind))
	fillHQ()

func _on_hero_deck_setup_hq() -> void:
	fillHQ()
	calcHQZones()
