extends ColorRect

func _ready():
	Events.connect("power_change", _on_power_change)

func _on_power_change(value):
	material.set("shader_parameter/OPACITY", value)
