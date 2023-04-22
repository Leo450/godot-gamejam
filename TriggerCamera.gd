extends Area2D

@export var is_horizontal = true

var can_trigger = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if !can_trigger:
		return
		
	can_trigger = false
	
	var direction = body.last_input_vector
	if (is_horizontal):
		direction.x = 0
	else:
		direction.y = 0
	
	Events.emit_signal("translate_camera", direction)
	
	await Events.finished_translation
	can_trigger = true
