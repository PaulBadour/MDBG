extends "res://scripts/Pile.gd"

const OOS = Vector2(-600, -420)
var ignoreSend = false

#@warning_ignore("unused_parameter")
#func _process(delta: float) -> void:
	#for i in cards:
		#if i.position != OOS:
			#i.position = OOS

func addCards(i):
	super(i)
	#print("Adding ", i)
	if ignoreSend:
		#print("Ignore Send")
		ignoreSend = false
	elif $"../..".playerCount > 1:
		$"../..".socket.send_text(str("KO:", GameData.getCardCode(i)))
