extends Node2D

const TEXT_FONT = 50
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_child(0).add_theme_font_size_override("font_size", TEXT_FONT)


func _on_player_hand_discard_count(number) -> void:
	get_child(0).text = str("Discard: ", number)
