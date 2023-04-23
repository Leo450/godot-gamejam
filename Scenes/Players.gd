extends Node2D

func _ready():
	Events.connect("easter_egg", _on_easter_egg)
	for child in get_children():
		if child.PLAYER_ID == 2:
			child.hide()
			child.set_process_mode(4)

func _on_easter_egg(value):
	var shown = null
	var hidden = null
	for child in get_children():
		if child.PLAYER_ID == value:
			shown = child
			child.show()
			child.set_process_mode(0)
		else:
			hidden = child
			child.hide()
			child.set_process_mode(4)
