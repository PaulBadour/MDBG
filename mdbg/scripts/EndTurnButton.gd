extends Button

const BUTTON_FONT = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_theme_font_size_override("font_size", BUTTON_FONT)
