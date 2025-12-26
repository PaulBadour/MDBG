extends Node2D

'''
A = Autoplay
D = Discard
V = Vicpile
P = Played
'''

var isFocused = false

var cardDragged
var screenSize
var isHovering
var cardZoomed
var oldZoomPos

const BASE_SIZE = .5
const HIGHLIGHT_SIZE = .75
const PLAY_ZONE = 400
const ZOOM_SCALE = 2

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if $"../BlackScreen".isClickable:
		return
	if isFocused:
		return
	if event is InputEventKey and event.keycode == KEY_D and !event.is_echo():
		if event.is_pressed():
			$"../BlackScreen".showCards($"../PlayerHand".deck.discard, false)
		else:
			$"../BlackScreen".stopShowCards()
	if event is InputEventKey and event.keycode == KEY_V and !event.is_echo():
		if event.is_pressed():
			$"../BlackScreen".showCards($"../PlayerHand".vicPile, false)
		else:
			$"../BlackScreen".stopShowCards()
	if event is InputEventKey and event.keycode == KEY_P and !event.is_echo():
		if event.is_pressed():
			$"../BlackScreen".showCards($"../PlayerHand".played, false)
		else:
			$"../BlackScreen".stopShowCards()
	# DEBUG
	if event is InputEventKey and event.keycode == KEY_N and !event.is_echo() and event.is_pressed():
		var c = findCard(false)
		if c:
			print(c)
	if event is InputEventKey and event.keycode == KEY_SPACE and !event.is_echo():
		#$"../BlackScreen".appear()
		if event.is_pressed() and !cardDragged:
			var c = findCard()
			if c:
				cardZoomed = c
				oldZoomPos = c.position
				c.position = Vector2(screenSize.x / 2.0, screenSize.y / 2.0)
				c.scale = Vector2(ZOOM_SCALE, ZOOM_SCALE)
				c.z_index = 5
				if c.identifier == "Villain":
					c.displayBystanders(true)
				elif c.identifier == "Mastermind":
					$"../Mastermind".displayBystanders(true)
		elif event.is_released() and cardZoomed:
			cardZoomed.position = oldZoomPos
			cardZoomed.scale = Vector2(BASE_SIZE, BASE_SIZE)
			cardZoomed.z_index = 3
			hoverOff(cardZoomed)
			if cardZoomed.identifier == "Villain":
				cardZoomed.displayBystanders(false)
			elif cardZoomed.identifier == "Mastermind":
				$"../Mastermind".displayBystanders(false)
			cardZoomed = null
			
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and !cardZoomed:
		if event.is_pressed():
			var c = findCard()
			if c and $"../PlayerHand".isCardInHand(c):
				cardDragged = c
		elif cardDragged:
			if cardDragged.position.y < PLAY_ZONE:
				$"../PlayerHand".playCard(cardDragged)
			elif $"../PlayerHand".isCardInHand(cardDragged):
				$"../PlayerHand".animateCard(cardDragged, cardDragged.handPos)
			cardDragged = null

func findCard(first=true):
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = 1
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		if !first:
			var ret = []
			for i in result:
				ret.append(i.collider.get_parent())
			return ret
		var topCard = result[0].collider.get_parent()
		for i in range(1, result.size()):
			if result[i].collider.get_parent().z_index > topCard.z_index:
				topCard = result[i].collider.get_parent()
		return topCard
	return null

func hoverOn(card):
	return
	if !isHovering and !cardZoomed and !isFocused:
		highlightCard(card, true)
		isHovering = true

func hoverOff(card):
	#print("HoverOff")
	if cardZoomed:
		return
	highlightCard(card, false)
	#isHovering = false
	var newCard = findCard()
	if newCard and $"../PlayerHand".isCardInHand(card) and !isFocused:
		highlightCard(newCard, true)
	else:
		isHovering = false

@warning_ignore("unused_parameter")
func highlightCard(card, hovered):
	pass
	#if hovered and $"../PlayerHand".isCardInHand(card):
		#card.scale = Vector2(HIGHLIGHT_SIZE, HIGHLIGHT_SIZE)
		#card.z_index = 2
	#else:
		##print(str("Resetting card", card))
		#card.scale = Vector2(BASE_SIZE, BASE_SIZE)
		#card.z_index = 1

func connectCardSignals(card):
	card.connect("hovOn", hoverOn)
	card.connect("hovOff", hoverOff)

func connectBystanderSignal(card):
	card.connect("bystanderLabel", $"../ExtraLabels".showLabel)
	card.connect("removeBystanderLabel", $"../ExtraLabels".removeLabel)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screenSize = get_viewport_rect().size # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("UNUSED_PARAMETER")
func _process(delta: float) -> void:
	if cardDragged:
		var mpos = get_global_mouse_position()
		cardDragged.position = Vector2(clamp(mpos.x, 0, screenSize.x), clamp(mpos.y, 0, screenSize.y))


func _on_hq_focused_hq() -> void:
	isFocused = true
	if isHovering:
		isHovering = false
		highlightCard(findCard(), false)


func _on_hq_un_focus_hq() -> void:
	isFocused = false
