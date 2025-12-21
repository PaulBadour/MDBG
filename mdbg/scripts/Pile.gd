extends Node2D

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
	if num == 1:
		return cards[0]
	var c = cards.slice(0, num-1)
	return c
	
func shuffle():
	cards.shuffle()
