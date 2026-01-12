extends Node2D
class_name Modifier

var target
var onEffect: Callable
var offEffect: Callable
var textDisplay: String
var mName: String
var mmover: bool

# Called when the node enters the scene tree for the first time.
func apply(c):
	if c.identifier == "MMHandler":
		c.mCard.addExtraText(textDisplay, str("Modifier-", mName))
	else:
		c.addExtraText(textDisplay, str("Modifier-", mName))
	if mmover:
		target = c.mCard
	else:
		target = c
	onEffect.call(target)
	

func remove():
	offEffect.call(target)
	if target.identifier == "MMHandler":
		target.mCard.removeExtraText(str("Modifier-", mName))
	else:
		target.removeExtraText(str("Modifier-", mName))

func createMod(info):
	onEffect = info.onEffect
	offEffect = info.offEffect
	textDisplay = info.text
	mName = info.mName
	mmover = info.mmover
