extends Area2D

@export var offset = Vector2.ZERO
var can_trigger = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if can_trigger:
		can_trigger = false
		
		Events.emit_signal("translate_camera", offset)
		
		if offset.x != 0:
			body.global_position.x = global_position.x + sign(offset.x) * 8
		if offset.y != 0:
			body.global_position.y = global_position.y + sign(offset.y) * 8
			
		offset *= -1
		
		await Events.finished_translation
		can_trigger = true
