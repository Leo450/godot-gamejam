extends Area2D

@export var enabled = true
@export var is_horizontal = true

func _ready():
	Events.connect("cinematik_done", _on_cinematik_done)

func _on_body_entered(body):
	if enabled:
		Events.emit_signal("cinematik")

func _on_cinematik_done():
	enabled = false
