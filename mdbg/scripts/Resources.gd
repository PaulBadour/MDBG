extends Node2D

const TEXT_FONT = 50

var attack
var recruit



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Attack.add_theme_font_size_override("font_size", TEXT_FONT)
	$Recruit.add_theme_font_size_override("font_size", TEXT_FONT)
	$UsernameLabel.add_theme_font_size_override("font_size", TEXT_FONT)
	$UsernameLabel.text = $"../..".username
	attack = 0
	recruit = 0


func _on_player_hand_add_attack(num) -> void:
	addAttack(num)


func _on_player_hand_add_recruit(num) -> void:
	addRecruit(num)


func _on_player_hand_end_turn() -> void:
	attack = 0
	recruit = 0
	$Attack.text = str("Attack: ", attack)
	$Recruit.text = str("Recruit: ", recruit)

func addAttack(num):
	attack += num
	$Attack.text = str("Attack: ", attack)
	
func addRecruit(num):
	recruit += num
	$Recruit.text = str("Recruit: ", recruit)
