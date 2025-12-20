extends Node2D

var cardDragged
var screenSize
var isHovering


const BASE_SIZE = .5
const HIGHLIGHT_SIZE = .75

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			var c = findCard()
			if c:
				cardDragged = c
		elif cardDragged:
			if cardDragged.position.y < 150:
				$"../PlayerHand".removeFromHand(cardDragged)
			else:
				$"../PlayerHand".animateCard(cardDragged, cardDragged.handPos)
			cardDragged = null

func findCard():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = 1
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		var topCard = result[0].collider.get_parent()
		for i in range(1, result.size()):
			if result[i].collider.get_parent().z_index > topCard.z_index:
				topCard = result[i].collider.get_parent()
		return topCard
	return null

func hoverOn(card):
	if !isHovering:
		highlightCard(card, true)
		isHovering = true

func hoverOff(card):
	highlightCard(card, false)
	#isHovering = false
	var newCard = findCard()
	if newCard:
		highlightCard(newCard, true)
	else:
		isHovering = false
func highlightCard(card, hovered):
	if hovered:
		card.scale = Vector2(HIGHLIGHT_SIZE, HIGHLIGHT_SIZE)
		card.z_index = 2
	else:
		card.scale = Vector2(BASE_SIZE, BASE_SIZE)
		card.z_index = 1

func connectCardSignals(card):
	card.connect("hovOn", hoverOn)
	card.connect("hovOff", hoverOff)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screenSize = get_viewport_rect().size # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cardDragged:
		var mpos = get_global_mouse_position()
		cardDragged.position = Vector2(clamp(mpos.x, 0, screenSize.x), clamp(mpos.y, 0, screenSize.y))
