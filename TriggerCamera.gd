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
		direction.y = sign(direction.y)
	else:
		direction.y = 0
		direction.x = sign(direction.x)
	
	var can_move = !body.test_move(body.transform, direction * 14)
	
	if can_move:
		Events.emit_signal("translate_camera", direction)
		await Events.finished_translation
	else:
		Events.emit_signal("nop_camera", direction)
		
	can_trigger = true
