extends Camera2D

var isMoving = false

func _ready():
	is_current()
	Events.connect("translate_camera", translate_camera)

func translate_camera(direction):
	if not isMoving:
		isMoving = true
		await create_tween().tween_property(self, "global_position", global_position + direction * Vector2(320, 180), 0.5).finished
		isMoving = false
		
	Events.emit_signal("finished_translation")
