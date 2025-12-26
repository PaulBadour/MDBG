extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()

func win():
	print("You win!")
	get_tree().quit()

func lose():
	print("You lose!")
	get_tree().quit()

func tie():
	print("You tied")
	get_tree().quit()
