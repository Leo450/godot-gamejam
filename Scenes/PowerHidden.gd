extends Node2D

func _ready():
	hide()
	Events.connect("power_change", _on_power_change)

func _on_power_change(value):
	if value:
		show()
	else:
		hide()
