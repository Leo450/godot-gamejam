extends Node2D

@export var nb_spots = 2

var current_spots = 0

func _ready():
	for child in get_children():
		child.connect("rock_status_changed", _on_rock_spot_rock_status_changed)

func _on_rock_spot_rock_status_changed(status):
	if status:
		current_spots += 1
	else:
		current_spots -= 1
	current_spots = clamp(current_spots, 0, nb_spots)
	
	if current_spots == nb_spots:
		Events.emit_signal("tile_0_5_done")
