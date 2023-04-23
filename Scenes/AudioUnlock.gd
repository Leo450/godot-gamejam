extends AudioStreamPlayer

func _ready():
	Events.connect("tile_0_5_done", _on_tile_done)
	Events.connect("tile_1_5_done", _on_tile_done)

func _on_tile_done():
	if playing:
		stop()
	play()
