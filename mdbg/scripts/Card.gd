extends Node2D

signal hovOn
signal hovOff

var handPos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.scale = Vector2(.5, .5)
	get_parent().connectCardSignals(self) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func initSprite(path):
	var loadedPath = load(path)
	$CardImage.texture = loadedPath

func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovOn", self) # Replace with function body.


func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovOff", self)
