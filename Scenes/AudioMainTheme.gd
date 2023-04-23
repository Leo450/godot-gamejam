extends AudioStreamPlayer

func _ready():
	Events.connect("power_change", _on_power_change)

func _on_power_change(value):
	if value:
		pitch_scale = .6
		volume_db = 6
	else:
		pitch_scale = 1
		volume_db = 4
