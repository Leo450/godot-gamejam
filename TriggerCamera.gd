extends Area2D

@export var enabled = true
@export var is_horizontal = true

var can_trigger = true

func _on_body_entered(body):
	if !enabled || !can_trigger:
		return
		
	can_trigger = false
	
	var direction = body.last_input_vector
	if (is_horizontal):
		direction.x = 0
	else:
		direction.y = 0
	
	body.change_map()
	
	Events.emit_signal("translate_camera", direction)
	
	await Events.finished_translation
	can_trigger = true
