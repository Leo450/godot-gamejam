extends StaticBody2D

func _ready():
	Events.connect("tile_0_5_done", _on_tile_0_5_done)

func _on_tile_0_5_done():
	queue_free()
