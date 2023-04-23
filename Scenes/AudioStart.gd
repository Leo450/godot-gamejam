extends Node2D


func _ready():
	Events.connect("cinematik", _on_cinematik)
	
	for child in get_children():
		child.play()

func _on_cinematik():
	for child in get_children():
		child.stop()
