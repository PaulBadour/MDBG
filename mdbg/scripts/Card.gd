extends Node2D

signal hovOn
signal hovOff

var handPos
var vp

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var size = get_parent().BASE_SIZE
	self.scale = Vector2(size, size)
	get_parent().connectCardSignals(self)
	#
	#var s = get_child(1).get_child(0).get_shape()
	#print(s.size)
	#$CardManager.add_child(self)
	

func initSprite(path):
	var loadedPath = load(path)
	$CardImage.texture = loadedPath

func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovOn", self)


func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovOff", self)
