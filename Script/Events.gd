extends Node

var is_power_unlocked = false
var power_state = false

signal translate_camera(offset)
signal finished_translation
signal nop_camera
signal power_change
signal power_unlocked
signal cinematik
signal cinematik_done
signal tile_0_5_done
signal tile_1_5_done
signal easter_egg

func _ready():
	Events.connect("cinematik_done", _on_cinematik_done)

func _process(delta):
	if !is_power_unlocked: return
	
	if Input.is_action_just_pressed("ui_focus_next"):
		toggle_power()

func toggle_power():
	power_state = !power_state
	Events.emit_signal("power_change", int(power_state))

func _on_cinematik_done():
	is_power_unlocked = true
	Events.emit_signal("power_unlocked")
