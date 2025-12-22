extends Node2D

const REVEAL_LOCATION = Vector2(900, 500)

var cards = []

func draw():
	if cards.size() > 0:
		return cards.pop_front()
	return null

func addCards(c):
	if typeof(c) != TYPE_ARRAY:
		cards.insert(0, c)
	else:
		for i in c:
			cards.insert(0, i)

func count():
	return cards.size()

func getTop(num=1):
	if cards.size() == 0:
		return null
	if num == 1:
		return cards[0]
	var c = cards.slice(0, num-1)
	return c

func reveal():
	var c = getTop()
	if !c:
		pass
	var oldz = c.z_index
	#var oldscale = c.scale
	c.position = REVEAL_LOCATION
	c.z_index = 10
	#c.scale = Vector2(3, 3)
	await get_tree().create_timer(1.5).timeout
	c.position = Vector2(-500, 0)
	c.z_index = oldz
	#c.scale = oldscale
	return c

func shuffle():
	cards.shuffle()
