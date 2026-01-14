extends Node2D

var cost
var maxRec
var maxAtt
var overwrite = false

signal sliderFinished

func setup(c, att, rec):
	cost = c
	maxAtt = att
	maxRec = rec
	$"Attack Slider".max_value = maxAtt if maxAtt <= cost else cost
	$"Recruit Slider".max_value = maxRec if maxRec <= cost else cost
	
	$"Attack Slider".tick_count = maxAtt+1 if maxAtt <= cost else cost+1
	$"Recruit Slider".tick_count = maxRec+1 if maxRec <= cost else cost+1
	
	$"Recruit Slider".value = maxRec if maxRec <= cost else cost
	$"Attack Slider".value = cost - $"Recruit Slider".value
	
	$CostLabel.text = str("Cost: ", cost)
	
	$AttackLabel.text = str("Attack: ", int($"Attack Slider".value))
	$RecruitLabel.text = str("Recruit: ", int($"Recruit Slider".value))
	$".".visible = true

func _on_attack_slider_value_changed(value: float) -> void:
	if value + $"Recruit Slider".value < cost and $"Recruit Slider".value == maxRec:
		value = cost - $"Recruit Slider".value
		$"Attack Slider".value = value
	$AttackLabel.text = str("Attack: ", int(value))
	if not overwrite:
		overwrite = true
		$"Recruit Slider".value = cost - value
		overwrite = false

func _on_recruit_slider_value_changed(value: float) -> void:
	if value + $"Attack Slider".value < cost and $"Attack Slider".value == maxAtt:
		value = cost - $"Attack Slider".value
		$"Recruit Slider".value = value
	$RecruitLabel.text = str("Recruit: ", int(value))
	if not overwrite:
		overwrite = true
		$"Attack Slider".value = cost - value
		overwrite = false

func _on_fight_pressed() -> void:
	$".".visible = false
	emit_signal("sliderFinished", $"Recruit Slider".value)

func _on_cancel_pressed() -> void:
	$".".visible = false
	emit_signal("sliderFinished", null)
