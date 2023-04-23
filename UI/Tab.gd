extends Sprite2D

var power_unlocked = false
var has_been_shown_once = false

func _ready():
	hide()
	Events.connect("power_unlocked", _on_power_unlocked)
	Events.connect("power_change", _on_power_change)
	

func _on_power_unlocked():
	power_unlocked = true
	show()

func _on_power_change(value):
	if !power_unlocked: return
	if !has_been_shown_once && value:
		hide()
		has_been_shown_once = true
