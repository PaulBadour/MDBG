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
		var xButton = START_X - (zone * DECR) + BUTTON_X_OFFSET
		$Fight.position = Vector2(xButton, y - BUTTON_Y_OFFSET)
		$Cancel.position = Vector2(xButton, y + BUTTON_Y_OFFSET)

func _input(event: InputEvent) -> void:
	if $"../BlackScreen".isClickable:
		return
	if $"../HQ".focused:
		return
	if event is InputEventKey and event.keycode == KEY_V and event.is_pressed():
		startTurn()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and !focused:
		var pos = get_viewport().get_mouse_position()
		if pos.y < CHECK_Y_MIN or pos.y > CHECK_Y_MAX:
			return
		var zone = -1
		for i in range(5):
			if pos.x > cityZones[i][0] and pos.x < cityZones[i][1]:
				zone = i
				break
		if zone >= 0:
			focus(zone) 


func _on_fight_button_down() -> void:
	var attack = city[focused].attack
	var currAttack = $"../Resources".attack
	if currAttack >= attack:
		$"../Resources".addAttack(-attack)
		$"../PlayerHand".vicPile.append(city[focused])
		city[focused].position = OOS
		
		# RUN ANY FIGHT EFFECTS
		
		city[focused] = null
	_on_cancel_button_down()


func _on_cancel_button_down() -> void:
	emit_signal("unFocusCity")
	$Fight.position = Vector2(-400, y - BUTTON_Y_OFFSET)
	$Cancel.position = Vector2(-400, y + BUTTON_Y_OFFSET)
	focused = null

func addToCity(c):
	var i = 0
	city[i] = c
	c.position = Vector2(START_X - (i * DECR), y)
	c.z_index = 3

func startTurn():
	var vc = $"../VillainDeck".draw()
	if vc.identifier == "Villain":
		addToCity(vc)
