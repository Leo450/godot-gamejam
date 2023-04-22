extends Area2D

@export var offset:Vector2 = Vector2.ZERO
var canTrigger = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if canTrigger:
		canTrigger = false
		Events.emit_signal("translateCamera", offset)
		offset *= -1
		await Events.finishedTranslation
		canTrigger = true
