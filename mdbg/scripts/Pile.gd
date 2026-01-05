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
	print("In getTop")
	if cards.size() == 0:
		print("returning null")
		return null
	if num == 1:
		print("returning 1")
		return cards[0]
	print(cards)
	var c = cards.slice(0, num)
	return c

func reveal(n=1):
	if n > 1:
		#print("revealing ", n)
		var t = getTop(n)
		#print(n, t)
		return t
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

func shuffle(sc=null):
	if sc:
		#print("Shuffle Code: ", sc)
		var i = 0
		while i < cards.size():
			if sc[i] == i:
				i += 1
			else:
				var swap1 = i
				var swap2 = sc[i]

				var temp = sc[swap1]
				sc[swap1] = sc[swap2]
				sc[swap2] = temp
		
				temp = cards[swap1]
				cards[swap1] = cards[swap2]
				cards[swap2] = temp
	else:
		var shuffleCode = []
		for i in range(0, cards.size()):
			shuffleCode.append(i)
		
		shuffleCode.shuffle()
		
		shuffle(shuffleCode.duplicate(true))
		return shuffleCode
