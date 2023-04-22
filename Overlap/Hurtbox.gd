extends Area2D

@export var SHOW_HIT = true

func _on_area_entered(area):
	queue_free()
