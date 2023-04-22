extends Camera2D

var isMoving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	is_current()
	Events.connect("translateCamera", translateCamera)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func translateCamera(offset):
	if not isMoving:
		isMoving = true
		await create_tween().tween_property(self, "global_position", global_position + offset, 0.5).finished
		isMoving = false
#	else:
#		await get_tree().idl
	Events.emit_signal("finishedTranslation")
