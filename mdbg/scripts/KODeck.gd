extends "res://scripts/Pile.gd"

const OOS = Vector2(-600, -420)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	for i in cards:
		if i.position != OOS:
			i.position = OOS
