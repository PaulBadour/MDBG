extends Node2D

signal hovOn
signal hovOff

var handPos
var vp
var identifier
var tName

var spritePath

var extraText = []
var extraLabels = []

const BASE_SIZE = .5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var size = BASE_SIZE
	self.scale = Vector2(size, size)
	get_parent().connectCardSignals(self)
	

func initSprite(path):
	var loadedPath = load(path)
	spritePath = path
	$CardImage.texture = loadedPath

func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovOn", self)


func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovOff", self)

func getExtraText():
	return "\n".join(extraText)

func addExtraText(text, label):
	extraText.append(text)
	extraLabels.append(label)

func removeExtraText(label):
	for i in range(extraText.size()):
		if extraLabels[i] == label:
			extraText.remove_at(i)
			extraLabels.remove_at(i)
			return


#func debugPos(p):
	#print(self)
	#print(str("Was at: ", position))
	#print(str("Now at: ", p))
	#position = p
