extends "res://scripts/Pile.gd"

const OOS = Vector2(-600, -420)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	for i in cards:
		if i.position != OOS:
			i.position = OOS
