extends StaticBody2D

@export var event_name = "tile_0_5_done"

func _ready():
	Events.connect(event_name, _on_tile_0_5_done)

func _on_tile_0_5_done():
	queue_free()
