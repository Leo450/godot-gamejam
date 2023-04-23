extends Node2D

func _ready():
	set_process_mode(4)
	hide()
	Events.connect("power_unlocked", _on_power_unlocked)

func _on_power_unlocked():
	set_process_mode(0)
	show()
