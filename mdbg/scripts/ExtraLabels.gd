extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func showLabel(string):
	get_node("CardInfo").text = string
	get_node("CardInfo").position = Vector2(1500, 500)

func removeLabel():
	get_node("CardInfo").position = Vector2(1500, -500)
