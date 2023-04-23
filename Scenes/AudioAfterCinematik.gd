extends Node2D


func _ready():
	Events.connect("cinematik_done", _on_cinematik_done)

func _on_cinematik_done():
	for child in get_children():
		child.play()
