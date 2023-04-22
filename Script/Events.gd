extends Node

var power_state = false

signal translate_camera(offset)
signal finished_translation
signal nop_camera
signal power_change

func toggle_power():
	power_state = !power_state
	emit_signal("power_change", int(power_state))
