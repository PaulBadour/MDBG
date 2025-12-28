extends Node2D

var scheme
var mastermind
var villains
var heros
const PLAYER_COUNT = 1

# Called when the node enters the scene tree for the first time.
func _init():
	randomize()
	scheme = GameData.PowerCosmicCube
	mastermind = GameData.RED_SKULL
	villains = [GameData.SPIDERFOES_VILLAINS, GameData.HENCHMAN_SENTINEL]
	heros = [GameData.Heros.IRON_MAN, GameData.Heros.CYCLOPS, GameData.Heros.HAWKEYE]

func _ready() -> void:
	await $BlackScreen.infoPanel()
	$City.drawVilCard()

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
