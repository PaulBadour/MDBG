extends Node2D


var PLAYER_COUNT
var username
var host
var yourTurn = false

# Called when the node enters the scene tree for the first time.
func _init():
	randomize()
	#scheme = GameData.PowerCosmicCube
	#mastermind = GameData.RED_SKULL
	#villains = [GameData.RADIATION_VILLAINS, GameData.RADIATION_VILLAINS, GameData.HENCHMAN_SENTINEL]
	#heros = [GameData.Heros.IRON_MAN, GameData.Heros.CYCLOPS, GameData.Heros.HAWKEYE, GameData.Heros.WOLVERINE, GameData.Heros.SPIDER_MAN]

func start():
	PLAYER_COUNT = $"..".playerCount
	username = $"..".username
	host = $"..".host
	$BlackScreen.showInfoPanel()
	await get_tree().create_timer(5.0).timeout
	$BlackScreen.stopShowInfoPanel()
	newTurn()

func win():
	print("You win!")
	print("VP : ", get_node("PlayerHand").getVP())
	get_tree().quit()

func lose():
	print("You lose!")
	get_tree().quit()

func tie():
	print("You tied")
	get_tree().quit()

#func shouldSend():
	#return host and PLAYER_COUNT > 1

func newTurn():
	if $"..".turn == $"..".username:
		yourTurn = true
		$EndTurn.visible = true
	else:
		yourTurn = false
		$EndTurn.visible = false
	$City.drawVilCard()

#func setupComplete():
	#emit_signal("setupDone")
