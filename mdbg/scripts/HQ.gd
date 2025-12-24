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

var hq = [null, null, null, null, null]
var hqZones = [null, null, null, null, null]
# 1300 . 
# at 275

var focused = null

# Cancel button
func _on_cancel_button_down() -> void:
	emit_signal("unFocusHQ")
	$Recruit.position = Vector2(-400, y - BUTTON_Y_OFFSET)
	$Cancel.position = Vector2(-400, y + BUTTON_Y_OFFSET)
	focused = null

# Recruit button
func _on_recruit_button_down() -> void:
	var cost = hq[focused].cost
	var currRecruit = $"../Resources".recruit
	if currRecruit >= cost:
		$"../Resources".addRecruit(-cost)
		$"../PlayerHand".deck.discardCard(hq[focused])
		hq[focused] = null
		$"../PlayerHand".killOrRecruit = true
		fillHQ()
	_on_cancel_button_down()

func focus(zone):
	if focused == null:
		emit_signal("focusedHQ")
		focused = zone
		var xButton = START_X - (zone * DECR) + BUTTON_X_OFFSET
		$Recruit.position = Vector2(xButton, y - BUTTON_Y_OFFSET)
		$Cancel.position = Vector2(xButton, y + BUTTON_Y_OFFSET)

func _input(event: InputEvent) -> void:
	if $"../BlackScreen".isClickable:
		return
	if $"../City".focused:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and !focused:
		var pos = get_viewport().get_mouse_position()
		if pos.y < CHECK_Y_MIN or pos.y > CHECK_Y_MAX:
			return
		var zone = -1
		for i in range(5):
			if pos.x > hqZones[i][0] and pos.x < hqZones[i][1]:
				zone = i
				break
		#print(str("Zone clicked: ", zone))
		if zone >= 0:
			focus(zone)

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

func _on_hero_deck_setup_hq() -> void:
	fillHQ()
	calcHQZones()
